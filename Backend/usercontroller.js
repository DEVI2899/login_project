const UserService = require('./user_service');
const config= require('./dbConfig');
const sql = require('mssql');
const bcrypt = require('bcrypt');
const userService = new UserService();
const jwt = require('jsonwebtoken');

class UserController {
    async register(req, res) {
        try {
            const { username, email, password } = req.body;
            const user = await userService.registerUser(username, email, password);
            if (user.length> 0) {
              return res.status(400).json({ message: 'User already registered with this email' });
           }else{
            return  res.status(201).json({ status: 'success', message: 'User Registered!',
                                             data: {
                                               user: {
                                                  id : user.id,
                                                  email: user.email,
                                               },
                                             },
                                           });
           }
           res.json(user);
        } catch (err) {
            res.status(500).send({ message: err.message });
        }
    }

     async login(req, res) {
             const { email, password } = req.body;
             try {
                 const user = await userService.getUserByEmail(email);
                 if (!user) {
                     return res.status(401).json({ message: 'Invalid email or password' });
                 }
                const token = jwt.sign({ userId: user.id, email: user.email }, 'SecretKey', { expiresIn: '1h' });
                 const isMatch = await bcrypt.compare(password, user.password);
                 if (!isMatch) {
                     return res.status(401).json({ message: 'Invalid email or password' });
                 }else{
                      return  res.status(201).json({ status: 'success', message: 'User Logged in',
                                                               data: {
                                                                 user: {
                                                                    username :user.username,
                                                                    email: user.email,
                                                                 },
                                                                 token
                                                               },
                                                          });
                        }


                 res.status(200).json({ token });
             } catch (err) {
                 res.status(500).json({ message: err.message });
             }
         }

         async getUsers(req, res) {
             const users = await userService.getUsers();
              if (!users) {
                 return res.status(401).json({ message: 'User List Empty' });
                }else{
                 return res.json(users);
             }
           }
           async getUsersId(req, res) {
                        const users = await userService.getUsersId(req.params.id);
                         if (!users) {
                            return res.status(401).json({ message: 'User id Empty' });
                           }else{
                            return res.json(users);
                        }
                      }

}

module.exports = new UserController();
