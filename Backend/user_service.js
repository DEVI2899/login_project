const {sql, poolPromise }= require('./dbConfig');
const bcrypt = require('bcrypt');
const User = require('./user');

class UserService {
    async  registerUser(username, email, password) {
        try {
            const pool = await poolPromise;
           // const hashedPassword = await bcrypt.hash(password, 8);
            const result = await pool.request()
                .input('username', sql.NVarChar, username)
                .input('email', sql.NVarChar, email)
                .input('password', sql.NVarChar,password )
                .execute('spCreateUser');
                const userId = result.recordset.UserID;
                return new User(userId, username, email, password);
        } catch (err) {
            throw Error(err.message);
        }
    }

    async  loginUser(email, password) {
        try {
            let pool = await sql.connect(config);
            const result = await pool.request()
                .input('email', sql.NVarChar, email)
                .execute('spGetUserByEmail');
             //   .query('SELECT * FROM users WHERE email = @email');
            const row = result.recordset[0];
            if (row && await bcrypt.compare(password, row.password)) {
                return User(row.id, row.username, row.email, row.password);
            } else {
                throw Error('Invalid email or password');
            }
        } catch (err) {
            throw new Error(err.message);
        }
    }


}

module.exports = UserService;
