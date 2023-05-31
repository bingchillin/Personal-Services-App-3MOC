import { User } from './Model';
import { Pool, PoolConnection } from 'mysql2/promise';

import db from '../services/mysql';
import { debug } from 'console';

export const UserRepository = {

    getAll: async (): Promise<any[]> => {
        try {
          const connection: PoolConnection = await db.getConnection();
          const [rows] = await connection.query('SELECT * FROM users');
           
          //if (Array.isArray(rows) && rows.length > 0) {
            const user = rows as any;
            //debug(user);
            return user;
          //} else {
            //return null;
          //}
          
        } catch (error) {
          throw error;
        }
      },

  createUser: async (user: User): Promise<User> => {
    try {
      const connection: PoolConnection = await db.getConnection();

      const [rows] = await connection.execute('INSERT INTO users SET ?', user);

      const createdUser: User = { ...user};
      return createdUser;
    } catch (error) {
      throw error;
    }
  },

  getUserById: async (id: String): Promise<User | null> => {
    try {
      const connection: PoolConnection = await db.getConnection();

      const [rows] = await connection.query('SELECT * FROM users WHERE id = ?', [id]);

      if (Array.isArray(rows) && rows.length > 0) {
        const user: User = rows[0] as User;
        return user;
      } else {
        return null;
      }
      
    } catch (error) {
      throw error;
    }
  },

  updateUser: async (user: User): Promise<User> => {
    try {
      const connection: PoolConnection = await db.getConnection();

      await connection.execute('UPDATE users SET ? WHERE id = ?', [user, user.id]);

      return user;
    } catch (error) {
      throw error;
    }
  },

  deleteUser: async (id: String): Promise<void> => {
    try {
      const connection: PoolConnection = await db.getConnection();

      await connection.execute('DELETE FROM users WHERE id = ?', [id]);
    } catch (error) {
      throw error;
    }
  },
};
