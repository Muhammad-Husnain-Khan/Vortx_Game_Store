const { getPool, sql } = require('../config/db');

exports.getAllCategories = async (req, res) => {
  try {
    const pool = getPool();
    const result = await pool.request().execute('sp_GetAllCategories');
    res.json({ categories: result.recordset });
  } catch (error) {
    console.error('Get categories error:', error.message);
    res.status(500).json({ error: 'Failed to fetch categories.' });
  }
};

exports.getAllPublishers = async (req, res) => {
  try {
    const pool = getPool();
    const result = await pool.request().execute('sp_GetAllPublishers');
    res.json({ publishers: result.recordset });
  } catch (error) {
    console.error('Get publishers error:', error.message);
    res.status(500).json({ error: 'Failed to fetch publishers.' });
  }
};
