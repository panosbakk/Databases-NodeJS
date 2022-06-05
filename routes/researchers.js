const express = require('express');
const researcherscontroller = require('../controllers/researchers');

const router = express.Router();

router.get('/young-researchers', researcherscontroller.getyoungResearchers);
router.post('/create', researcherscontroller.createResearcher);
router.get('/', researcherscontroller.getResearchers);
router.post('/delete/:id', researcherscontroller.postDeleteResearcher);

module.exports = router;