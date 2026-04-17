const { getPool, sql } = require('../config/db');

exports.getDashboardStats = async (req, res) => {
  try {
    const pool = getPool();
    const result = await pool.request().execute('sp_AdminGetDashboardStats');
    res.json({ stats: result.recordset[0] });
  } catch (error) {
    console.error('Dashboard stats error:', error.message);
    res.status(500).json({ error: 'Failed to fetch dashboard stats.' });
  }
};

exports.getAllUsers = async (req, res) => {
  try {
    const pool = getPool();
    const result = await pool.request().execute('sp_GetUsersWithOrderCount');
    res.json({ users: result.recordset });
  } catch (error) {
    console.error('Get users error:', error.message);
    res.status(500).json({ error: 'Failed to fetch users.' });
  }
};

exports.getAllGames = async (req, res) => {
  try {
    const pool = getPool();
    const result = await pool.request().execute('sp_AdminGetAllGames');
    res.json({ games: result.recordset });
  } catch (error) {
    console.error('Admin get games error:', error.message);
    res.status(500).json({ error: 'Failed to fetch games.' });
  }
};

exports.toggleGameActive = async (req, res) => {
  try {
    const pool = getPool();
    await pool.request()
      .input('GameID', sql.Int, req.params.id)
      .input('IsActive', sql.Bit, req.body.isActive)
      .execute('sp_AdminToggleGameActive');
    res.json({ message: 'Game status updated.' });
  } catch (error) {
    console.error('Toggle game error:', error.message);
    res.status(500).json({ error: 'Failed to update game status.' });
  }
};

exports.toggleFeatured = async (req, res) => {
  try {
    const pool = getPool();
    await pool.request()
      .input('GameID', sql.Int, req.params.id)
      .input('IsFeatured', sql.Bit, req.body.isFeatured)
      .execute('sp_AdminToggleFeatured');
    res.json({ message: 'Featured status updated.' });
  } catch (error) {
    console.error('Toggle featured error:', error.message);
    res.status(500).json({ error: 'Failed to update featured status.' });
  }
};

exports.deleteGame = async (req, res) => {
  try {
    const pool = getPool();
    await pool.request()
      .input('GameID', sql.Int, req.params.id)
      .input('HardDelete', sql.Bit, 1)
      .execute('sp_RemoveGame');
    res.json({ message: 'Game deleted.' });
  } catch (error) {
    console.error('Delete game error:', error.message);
    res.status(500).json({ error: 'Failed to delete game. It may have order history.' });
  }
};

exports.toggleUserActive = async (req, res) => {
  try {
    const pool = getPool();
    await pool.request()
      .input('UserID', sql.Int, req.params.id)
      .input('IsActive', sql.Bit, req.body.isActive)
      .execute('sp_AdminToggleUserActive');
    res.json({ message: 'User status updated.' });
  } catch (error) {
    console.error('Toggle user error:', error.message);
    res.status(500).json({ error: 'Failed to update user status.' });
  }
};

exports.getMonthlySales = async (req, res) => {
  try {
    const pool = getPool();
    const result = await pool.request().execute('sp_GetMonthlySalesReport');
    res.json({ report: result.recordset });
  } catch (error) {
    console.error('Monthly sales error:', error.message);
    res.status(500).json({ error: 'Failed to fetch monthly sales report.' });
  }
};

exports.getRevenuePerGame = async (req, res) => {
  try {
    const pool = getPool();
    const result = await pool.request().execute('sp_GetRevenuePerGame');
    res.json({ report: result.recordset });
  } catch (error) {
    console.error('Revenue per game error:', error.message);
    res.status(500).json({ error: 'Failed to fetch revenue report.' });
  }
};

exports.getAccountsList = async (req, res) => {
  try {
    const pool = getPool();
    const result = await pool.request().execute('sp_GetAllAccountsList');
    res.json({ accounts: result.recordset });
  } catch (error) {
    console.error('Accounts list error:', error.message);
    res.status(500).json({ error: 'Failed to fetch accounts list.' });
  }
};

exports.getPublisherAudit = async (req, res) => {
  try {
    const pool = getPool();
    const result = await pool.request().execute('sp_AuditPublishersAndGames');
    res.json({ audit: result.recordset });
  } catch (error) {
    console.error('Audit error:', error.message);
    res.status(500).json({ error: 'Failed to fetch audit report.' });
  }
};

exports.getWishlistedNotPurchased = async (req, res) => {
  try {
    const pool = getPool();
    const result = await pool.request().execute('sp_GetWishlistedNotPurchased');
    res.json({ games: result.recordset });
  } catch (error) {
    console.error('Wishlisted not purchased error:', error.message);
    res.status(500).json({ error: 'Failed to fetch report.' });
  }
};

exports.getPurchasedAndWishlisted = async (req, res) => {
  try {
    const pool = getPool();
    const result = await pool.request().execute('sp_GetGamesBothPurchasedAndWishlisted');
    res.json({ games: result.recordset });
  } catch (error) {
    console.error('Purchased and wishlisted error:', error.message);
    res.status(500).json({ error: 'Failed to fetch report.' });
  }
};

exports.applyDiscount = async (req, res) => {
  try {
    const pool = getPool();
    await pool.request()
      .input('GameID', sql.Int, req.params.id)
      .input('DiscountPercentage', sql.Decimal(5, 2), req.body.discountPercentage)
      .execute('sp_ApplyDiscount');
    res.json({ message: 'Discount applied.' });
  } catch (error) {
    console.error('Apply discount error:', error.message);
    res.status(500).json({ error: 'Failed to apply discount.' });
  }
};
