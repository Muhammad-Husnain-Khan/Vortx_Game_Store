const { getPool, sql } = require('../config/db');

exports.getWishlist = async (req, res) => {
  try {
    const pool = getPool();
    const result = await pool.request()
      .input('UserID', sql.Int, req.user.UserID)
      .execute('sp_GetUserWishlist');
    res.json({ wishlist: result.recordset });
  } catch (error) {
    console.error('Get wishlist error:', error.message);
    res.status(500).json({ error: 'Failed to fetch wishlist.' });
  }
};

exports.addToWishlist = async (req, res) => {
  try {
    const { gameId } = req.body;
    const pool = getPool();
    await pool.request()
      .input('UserID', sql.Int, req.user.UserID)
      .input('GameID', sql.Int, gameId)
      .input('Action', sql.VarChar(10), 'ADD')
      .execute('sp_ManageWishlist');
    res.json({ message: 'Added to wishlist.' });
  } catch (error) {
    console.error('Add wishlist error:', error.message);
    res.status(500).json({ error: 'Failed to add to wishlist.' });
  }
};

exports.removeFromWishlist = async (req, res) => {
  try {
    const pool = getPool();
    await pool.request()
      .input('UserID', sql.Int, req.user.UserID)
      .input('GameID', sql.Int, req.params.gameId)
      .input('Action', sql.VarChar(10), 'REMOVE')
      .execute('sp_ManageWishlist');
    res.json({ message: 'Removed from wishlist.' });
  } catch (error) {
    console.error('Remove wishlist error:', error.message);
    res.status(500).json({ error: 'Failed to remove from wishlist.' });
  }
};
