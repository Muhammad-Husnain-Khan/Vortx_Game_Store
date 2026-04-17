const sql = require('mssql')

const config = {
  server: process.env.DB_HOST || 'localhost',
  port: parseInt(process.env.DB_PORT) || 1433,
  database: process.env.DB_NAME || 'VortxGameStore',
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  options: {
    encrypt: false,
    trustServerCertificate: true
  }
}

async function connectDB() {
  try {
    await sql.connect(config)
    console.log('Connected to MS SQL Server')
  } catch (err) {
    console.error('Database connection failed:', err)
  }
}

module.exports = { connectDB, sql }
