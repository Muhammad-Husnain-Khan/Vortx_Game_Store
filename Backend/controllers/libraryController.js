const { getPool, sql } = require('../config/db');

exports.getLibrary = async (req, res) => {
  try {
    const pool = getPool();
    const result = await pool.request()
      .input('UserID', sql.Int, req.user.UserID)
      .execute('sp_GetUserLibrary');
    res.json({ library: result.recordset });
  } catch (error) {
    console.error('Get library error:', error.message);
    res.status(500).json({ error: 'Failed to fetch library.' });
  }
};

exports.checkOwnership = async (req, res) => {
  try {
    const pool = getPool();
    const result = await pool.request()
      .input('UserID', sql.Int, req.user.UserID)
      .input('GameID', sql.Int, req.params.gameId)
      .execute('sp_CheckOwnership');
    res.json({ owned: result.recordset[0].Owned > 0 });
  } catch (error) {
    console.error('Check ownership error:', error.message);
    res.status(500).json({ error: 'Failed to check ownership.' });
  }
};
