const router = require('express').Router();
const { getAllCategories, getAllPublishers } = require('../controllers/categoryController');

router.get('/', getAllCategories);
router.get('/publishers', getAllPublishers);

module.exports = router;
