const sql = require('mssql');


const config = {
  user: 'sa',
  password: '123',
  server: 'localhost',
  // server: 'localhost\\SQLEXPRESS',  // Uncomment for SQL Express
  database: 'VORTX_GameStore',
  options: {
    encrypt: true,
    trustServerCertificate: true  
  },
  pool: {
    max: 10,
    min: 0,
    idleTimeoutMillis: 30000
  }
};

let pool;

async function connectDB() {
  try {
    pool = await sql.connect(config);
    console.log('Connected to VORTX_GameStore database');
    return pool;
  } catch (err) {
    console.error('Database connection failed:', err.message);
    process.exit(1);
  }
}

function getPool() {
  if (!pool) {
    throw new Error('Database not connected. Call connectDB() first.');
  }
  return pool;
}

module.exports = { connectDB, getPool, sql };
