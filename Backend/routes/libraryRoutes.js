const router = require('express').Router();
const { getLibrary, checkOwnership } = require('../controllers/libraryController');
const { verifyToken, loadUser } = require('../middleware/auth');

router.get('/', verifyToken, loadUser, getLibrary);
router.get('/check/:gameId', verifyToken, loadUser, checkOwnership);

module.exports = router;
