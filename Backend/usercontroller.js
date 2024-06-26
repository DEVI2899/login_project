const UserService = require('./user_service');
const config= require('./dbConfig');
const sql = require('mssql');
const userService = new UserService();
const jwt = require('jsonwebtoken');

class UserController {


    async register(req, res) {
        try {
            const { username, email, password } = req.body;
            const user = await userService.registerUser(username, email, password);
            res.json(user);
        } catch (err) {
            res.status(500).send({ message: err.message });
        }
    }

    async  login(req, res) {
        try {
            const { email, password } = req.body;
            const user = await userService.loginUser(email, password);
            const token = jwt.sign({ id: user.id }, 'secretkey', { expiresIn: '1h' });
            res.json({ user, token });
        } catch (err) {
            res.status(500).send({ message: err.message });
        }
    }
}

module.exports = new UserController();
