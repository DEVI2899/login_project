var Connection = require('tedious').Connection;
var Request = require('tedious').Request;
var TYPES = require('tedious').TYPES;
const mssql = require('mssql');

const config = {
    connectionString: 'Driver={ODBC Driver 17 for SQL Server};Server=DESKTOP-PSS4370\\SQLEXPRESS01;Database=testing;Uid=Devika;Pwd=Devika@2;Encrypt=yes;TrustServerCertificate=yes;'
};

module.exports = config;

