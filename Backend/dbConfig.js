var Connection = require('tedious').Connection;
var Request = require('tedious').Request;
var TYPES = require('tedious').TYPES;
const sql = require('mssql');



const Config = {
    "user": 'Devika',          // Replace with your database username
    "password": 'Devika@2',      // Replace with your database password
    "server": 'DESKTOP-PSS4370\\SQLEXPRESS01',          // Replace with your database server, e.g., 'localhost' or 'DESKTOP-PSS4370\\SQLEXPRESS01'
    "database": 'testing',      // Replace with your database name
    "options": {
        encrypt: true,              // Use this if you're on Windows Azure
        trustServerCertificate: true // Use this if you're on a local machine
    },
};

const poolPromise = new sql.ConnectionPool(Config)
    .connect()
    .then(pool => {
        console.log('Connected to MSSQL');
        return pool;
    })
    .catch(err => {
        console.error('Database Connection Failed!', err);
        process.exit(1);
    });

    module.exports = {
        sql,
        poolPromise
    };



