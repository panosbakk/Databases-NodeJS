const express = require('express');
const projectsController = require('../controllers/projects');

const router = express.Router();

router.get('/', projectsController.getProjects);
router.post('/delete/:id', projectsController.postDeleteProject);

module.exports = router;