const { getPool, sql } = require('../config/db');

exports.submitReview = async (req, res) => {
  try {
    const { gameId, rating, reviewText } = req.body;
    
    if (!rating || rating < 1 || rating > 5) {
      return res.status(400).json({ error: 'Rating must be between 1 and 5.' });
    }

    const pool = getPool();
    await pool.request()
      .input('GameID', sql.Int, gameId)
      .input('UserID', sql.Int, req.user.UserID)
      .input('Rating', sql.Int, rating)
      .input('ReviewText', sql.VarChar(sql.MAX), reviewText || '')
      .execute('sp_SubmitReview');

    res.json({ message: 'Review submitted successfully.' });
  } catch (error) {
    console.error('Submit review error:', error.message);
    res.status(500).json({ error: 'Failed to submit review.' });
  }
};


exports.getTopRated = async (req, res) => {
  try {
    const pool = getPool();
    const result = await pool.request()
      .input('MinReviews', sql.Int, parseInt(req.query.min) || 1)
      .execute('sp_GetTopRatedGames');
    res.json({ games: result.recordset });
  } catch (error) {
    console.error('Top rated error:', error.message);
    res.status(500).json({ error: 'Failed to fetch top rated games.' });
  }
};
