const router = require('express').Router();
const { placeOrder, getOrderHistory } = require('../controllers/orderController');
const { verifyToken, loadUser } = require('../middleware/auth');

router.post('/', verifyToken, loadUser, placeOrder);
router.get('/history', verifyToken, loadUser, getOrderHistory);

module.exports = router;
