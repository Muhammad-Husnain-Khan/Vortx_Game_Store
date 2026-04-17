const { getPool, sql } = require('../config/db');

exports.getAllGames = async (req, res) => {
  try {
    const pool = getPool();
    const result = await pool.request().execute('sp_BrowseActiveGames');
    res.json({ games: result.recordset });
  } catch (error) {
    console.error('Get games error:', error.message);
    res.status(500).json({ error: 'Failed to fetch games.' });
  }
};

exports.getFeaturedGames = async (req, res) => {
  try {
    const pool = getPool();
    const result = await pool.request().execute('sp_GetFeaturedGames');
    res.json({ games: result.recordset });
  } catch (error) {
    console.error('Featured games error:', error.message);
    res.status(500).json({ error: 'Failed to fetch featured games.' });
  }
};

exports.searchGames = async (req, res) => {
  try {
    const { q } = req.query;
    if (!q) return res.status(400).json({ error: 'Search query required.' });
    
    const pool = getPool();
    const result = await pool.request()
      .input('Keyword', sql.VarChar(200), q)
      .execute('sp_SearchGamesByTitle');
    res.json({ games: result.recordset });
  } catch (error) {
    console.error('Search error:', error.message);
    res.status(500).json({ error: 'Search failed.' });
  }
};

exports.getGamesByCategory = async (req, res) => {
  try {
    const pool = getPool();
    const result = await pool.request()
      .input('CategoryName', sql.VarChar(50), req.params.name)
      .execute('sp_BrowseGamesByCategory');
    res.json({ games: result.recordset });
  } catch (error) {
    console.error('Category games error:', error.message);
    res.status(500).json({ error: 'Failed to fetch games by category.' });
  }
};

exports.getGamesAboveAverage = async (req, res) => {
  try {
    const pool = getPool();
    const result = await pool.request().execute('sp_GetGamesAboveAveragePrice');
    res.json({ games: result.recordset });
  } catch (error) {
    console.error('Above average error:', error.message);
    res.status(500).json({ error: 'Failed to fetch games.' });
  }
};

exports.getGameDetails = async (req, res) => {
  try {
    const pool = getPool();
    const result = await pool.request()
      .input('GameID', sql.Int, req.params.id)
      .execute('sp_GetGameDetails');

    if (result.recordsets[0].length === 0) {
      return res.status(404).json({ error: 'Game not found.' });
    }

    res.json({
      game: result.recordsets[0][0],
      categories: result.recordsets[1],
      images: result.recordsets[2],
      reviews: result.recordsets[3]
    });
  } catch (error) {
    console.error('Game details error:', error.message);
    res.status(500).json({ error: 'Failed to fetch game details.' });
  }
};

exports.addGame = async (req, res) => {
  try {
    const { gameTitle, description, publisherID, releaseDate, price, discountPercentage, 
            ageRating, fileSize, isFeatured, thumbnailPath, coverImagePath, trailerURL, systemRequirements } = req.body;
    
    const pool = getPool();
    const result = await pool.request()
      .input('GameTitle', sql.VarChar(200), gameTitle)
      .input('Description', sql.VarChar(sql.MAX), description)
      .input('PublisherID', sql.Int, publisherID)
      .input('ReleaseDate', sql.Date, releaseDate)
      .input('Price', sql.Decimal(10, 2), price)
      .input('DiscountPercentage', sql.Decimal(5, 2), discountPercentage || 0)
      .input('AgeRating', sql.VarChar(10), ageRating)
      .input('FileSize', sql.VarChar(50), fileSize)
      .input('IsFeatured', sql.Bit, isFeatured || 0)
      .input('ThumbnailPath', sql.VarChar(255), thumbnailPath)
      .input('CoverImagePath', sql.VarChar(255), coverImagePath)
      .input('TrailerURL', sql.VarChar(500), trailerURL)
      .input('SystemRequirements', sql.VarChar(sql.MAX), systemRequirements)
      .execute('sp_AddGame');

    res.status(201).json({ 
      message: 'Game submitted for review',
      gameId: result.recordset[0].NewGameID 
    });
  } catch (error) {
    console.error('Add game error:', error.message);
    res.status(500).json({ error: 'Failed to add game.' });
  }
};

exports.getTopRated = async (req, res) => {
  try {
    const pool = getPool();
    const result = await pool.request()
      .input('MinReviews', sql.Int, 1)
      .execute('sp_GetTopRatedGames');
    res.json({ games: result.recordset });
  } catch (error) {
    console.error('Top rated error:', error.message);
    res.status(500).json({ error: 'Failed to fetch top rated games.' });
  }
};
