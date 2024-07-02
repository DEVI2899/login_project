const {sql, poolPromise }= require('./dbConfig');
const bcrypt = require('bcrypt');
const User = require('./user');

class UserService {
    async  registerUser(username, email, password) {
        try {
            const pool = await poolPromise;
            const hashedPassword = await bcrypt.hash(password, 8);
            const result = await pool.request()
                .input('username', sql.NVarChar, username)
                .input('email', sql.NVarChar, email)
                .input('password', sql.NVarChar,hashedPassword)
                .execute('spInsertUser');
                const userId = result.recordset.UserID;
                return new User(userId, username, email, hashedPassword);
        } catch (err) {
            throw Error(err.message);
        }
    }

     async getUserByEmail(email) {
     try {
            const pool = await poolPromise;
            const result = await pool.request()
                .input('Email', sql.NVarChar, email)
                .execute('spGetUserByEmail');
            return result.recordset[0];

      } catch (err) {
                  throw Error(err.message);
              }

        }



}

module.exports = UserService;
