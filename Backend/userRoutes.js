const express = require('express');
const router = express.Router();
const userController = require('./usercontroller');


router.post('/register', userController.register);
router.post('/login', userController.login);
router.get('/getUsers', userController.getUsers);
router.get('/getUsers/:id', userController.getUsersId);


module.exports = router;