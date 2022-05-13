const express = require('express');
const layoutController = require('../controllers/layout');

const router = express.Router();

router.get('/', layoutController.getLanding);
router.get('/program-creation-page', layoutController.getCreateProgram)

module.exports = router;