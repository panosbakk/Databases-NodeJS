const express = require('express');
const programsController = require('../controllers/programs');

const router = express.Router();

router.get('/', programsController.getPrograms);
router.post('/create', programsController.postProgram);
router.post('/update/:id', programsController.postUpdateProgram);

module.exports = router;