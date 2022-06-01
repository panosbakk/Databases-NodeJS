const express = require('express');
const projectsController = require('../controllers/projects');

const router = express.Router();

router.get('/', projectsController.getProjects);
//router.post('/delete/:id', projectsController.postDeleteProject);
router.get('/show-researchers/:id', projectsController.getSelectResearcherProject);
router.post('/create', projectsController.postProject);
module.exports = router;