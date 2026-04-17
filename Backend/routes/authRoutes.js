const router = require('express').Router();
const { register, login, getMe } = require('../controllers/authController');
const { verifyToken, loadUser } = require('../middleware/auth');

router.post('/register', register);
router.post('/login', verifyToken, login);
router.get('/me', verifyToken, loadUser, getMe);

module.exports = router;
