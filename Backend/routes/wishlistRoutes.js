const router = require('express').Router();
const { getWishlist, addToWishlist, removeFromWishlist } = require('../controllers/wishlistController');
const { verifyToken, loadUser } = require('../middleware/auth');

router.get('/', verifyToken, loadUser, getWishlist);
router.post('/', verifyToken, loadUser, addToWishlist);
router.delete('/:gameId', verifyToken, loadUser, removeFromWishlist);

module.exports = router;
