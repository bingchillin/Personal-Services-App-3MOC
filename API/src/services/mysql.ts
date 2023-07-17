import { createPool, Pool, PoolConnection } from 'mysql2/promise';

const pool: Pool = createPool({
  host: process.env.DB_HOST || "localhost",
  user: process.env.DB_USER || "user",
  port: Number(process.env.DB_PORT) || 3306,
  password: process.env.DB_PASSWORD || "root",
  database: process.env.DB_NAME || 'api-goldie-db',
  waitForConnections: true,
  connectionLimit: 10,
});

//export default con;

const getConnection = async (): Promise<PoolConnection> => {
  try {
    const connection: PoolConnection = await pool.getConnection();
    return connection;
  } catch (error) {
    throw error;
  }
};

export default {
  getConnection,
};