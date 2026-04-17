const router = require('express').Router();
const adminCtrl = require('../controllers/adminController');
const { verifyToken, loadUser, requireAdmin } = require('../middleware/auth');

// All admin routes require auth + admin role
router.use(verifyToken, loadUser, requireAdmin);

router.get('/dashboard', adminCtrl.getDashboardStats);
router.get('/users', adminCtrl.getAllUsers);
router.get('/games', adminCtrl.getAllGames);
router.put('/games/:id/toggle-active', adminCtrl.toggleGameActive);
router.put('/games/:id/toggle-featured', adminCtrl.toggleFeatured);
router.put('/games/:id/discount', adminCtrl.applyDiscount);
router.delete('/games/:id', adminCtrl.deleteGame);
router.put('/users/:id/toggle-active', adminCtrl.toggleUserActive);
router.get('/reports/monthly-sales', adminCtrl.getMonthlySales);
router.get('/reports/revenue-per-game', adminCtrl.getRevenuePerGame);
router.get('/reports/accounts', adminCtrl.getAccountsList);
router.get('/reports/audit', adminCtrl.getPublisherAudit);
router.get('/reports/wishlisted-not-purchased', adminCtrl.getWishlistedNotPurchased);
router.get('/reports/purchased-and-wishlisted', adminCtrl.getPurchasedAndWishlisted);

module.exports = router;
