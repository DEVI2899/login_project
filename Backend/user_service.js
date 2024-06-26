const config= require('./dbConfig');
const sql = require('mssql');
const bcrypt = require('bcrypt');
const User = require('./user');

class UserService {
    async connectToDb() {
      try {
        await sql.connect(config);
        console.log('Connected to SQL Server database');
      } catch (error) {
        console.error('Error connecting to SQL Server:', error);
      }
    }

    async  registerUser(username, email, password) {
        try {
            let pool = await sql.connect(config);
            const hashedPassword = await bcrypt.hash(password, 8);
            const result = await pool.request()
                .input('username', sql.NVarChar, username)
                .input('email', sql.NVarChar, email)
                .input('password', sql.NVarChar, hashedPassword)
//                .execute('spInsertUser');
//                const userId = result.recordset.UserID;
//                return new User(userId, username, email, hashedPassword);
               .query('INSERT INTO users (username, email, password) OUTPUT INSERTED.* VALUES (@username, @email, @password)');
              const row = result.recordset;
             return User(row.id, row.username, row.email, row.password);
        } catch (err) {
            throw Error(err.message);
        }
    }

    async  loginUser(email, password) {
        try {
            let pool = await sql.connect(config);
            const result = await pool.request()
                .input('email', sql.NVarChar, email)
                .query('SELECT * FROM users WHERE email = @email');
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
