const { getPool, sql } = require('../config/db');

exports.register = async (req, res) => {
  try {
    const { username, email, password, firstName, lastName, dateOfBirth, country, firebaseUID } = req.body;
    const pool = getPool();
    const result = await pool.request()
      .input('Username', sql.VarChar(50), username)
      .input('Email', sql.VarChar(100), email)
      .input('Password', sql.VarChar(255), password || 'firebase_managed')
      .input('FirstName', sql.VarChar(50), firstName)
      .input('LastName', sql.VarChar(50), lastName)
      .input('DateOfBirth', sql.Date, dateOfBirth)
      .input('Country', sql.VarChar(50), country)
      .input('FirebaseUID', sql.VarChar(128), firebaseUID)
      .execute('sp_RegisterUser');

    res.status(201).json({ 
      message: 'User registered successfully',
      userId: result.recordset[0].NewUserID 
    });
  } catch (error) {
    if (error.message.includes('UNIQUE')) {
      return res.status(400).json({ error: 'Username or email already exists.' });
    }
    console.error('Register error:', error.message);
    res.status(500).json({ error: 'Registration failed.' });
  }
};

exports.login = async (req, res) => {
  try {
    const pool = getPool();
    const result = await pool.request()
      .input('FirebaseUID', sql.VarChar(128), req.firebaseUID)
      .execute('sp_LoginUser');

    if (result.recordset.length === 0) {
      return res.status(404).json({ error: 'User not found. Please register first.' });
    }

    res.json({ user: result.recordset[0] });
  } catch (error) {
    console.error('Login error:', error.message);
    res.status(500).json({ error: 'Login failed.' });
  }
};

exports.getMe = async (req, res) => {
  try {
    res.json({ user: req.user });
  } catch (error) {
    console.error('GetMe error:', error.message);
    res.status(500).json({ error: 'Failed to get profile.' });
  }
};
