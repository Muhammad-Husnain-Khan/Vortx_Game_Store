const router = require('express').Router();
const gameCtrl = require('../controllers/gameController');
const { verifyToken, loadUser } = require('../middleware/auth');

// Public routes
router.get('/', gameCtrl.getAllGames);
router.get('/featured', gameCtrl.getFeaturedGames);
router.get('/search', gameCtrl.searchGames);
router.get('/top-rated', gameCtrl.getTopRated);
router.get('/above-average', gameCtrl.getGamesAboveAverage);
router.get('/category/:name', gameCtrl.getGamesByCategory);
router.get('/:id', gameCtrl.getGameDetails);

// Protected routes
router.post('/', verifyToken, loadUser, gameCtrl.addGame);

module.exports = router;
