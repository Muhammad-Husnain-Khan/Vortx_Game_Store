const admin = require('../config/firebaseAdmin');


const verifyToken = async (req, res, next) => {
  const authHeader = req.headers.authorization;
  
  if (!authHeader || !authHeader.startsWith('Bearer ')) {
    return res.status(401).json({ error: 'No token provided. Please login.' });
  }

  const token = authHeader.split('Bearer ')[1];

  try {
    const decodedToken = await admin.auth().verifyIdToken(token);
    req.firebaseUID = decodedToken.uid;
    req.firebaseEmail = decodedToken.email;
    next();
  } catch (error) {
    console.error('Token verification failed:', error.message);
    return res.status(401).json({ error: 'Invalid or expired token.' });
  }
};

const loadUser = async (req, res, next) => {
  const { getPool, sql } = require('../config/db');

  try {
    const pool = getPool();
    const result = await pool.request()
      .input('FirebaseUID', sql.VarChar(128), req.firebaseUID)
      .execute('sp_GetUserByFirebaseUID');

    if (result.recordset.length === 0) {
      return res.status(404).json({ error: 'User not found in database.' });
    }

    const user = result.recordset[0];
    if (!user.IsActive) {
      return res.status(403).json({ error: 'Account has been suspended.' });
    }

    req.user = user;
    next();
  } catch (error) {
    console.error('Load user failed:', error.message);
    return res.status(500).json({ error: 'Server error loading user.' });
  }
};


const requireAdmin = (req, res, next) => {
  if (!req.user || req.user.Role !== 'admin') {
    return res.status(403).json({ error: 'Admin access required.' });
  }
  next();
};

const requireUser = (req, res, next) => {
  if (!req.user) {
    return res.status(403).json({ error: 'User access required.' });
  }
  next();
};

module.exports = { verifyToken, loadUser, requireAdmin, requireUser };
