const router = require('express').Router();
const { submitReview, getTopRated } = require('../controllers/reviewController');
const { verifyToken, loadUser } = require('../middleware/auth');

router.get('/top-rated', getTopRated);
router.post('/', verifyToken, loadUser, submitReview);

module.exports = router;
