import { User,validateUser } from './Model';
import { Pool, PoolConnection } from 'mysql2/promise';
import bcrypt from 'bcrypt';

import db from '../services/mysql';
import { debug } from 'console';

export const UserRepository = {

  getAll: async (): Promise<User[]> => {
    try {
      const connection: PoolConnection = await db.getConnection();
      const [rows] = await connection.query('SELECT * FROM users');
      const user = rows as any;
      return user;
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

  getUserByEmail: async (email: String): Promise<User | null> => {
    try {
      const connection: PoolConnection = await db.getConnection();

      const [rows] = await connection.query('SELECT * FROM users WHERE email = ?', [email]);

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

  getUserByLogs: async (email: string, password: string): Promise<User | null> => {
    try {
      const connection: PoolConnection = await db.getConnection();
  
      const [rows] = await connection.query('SELECT * FROM users WHERE email = ?', [email]);
  
      if (Array.isArray(rows) && rows.length > 0) {
        const user: User = rows[0] as User;
        const isPasswordMatch = await bcrypt.compare(password, user.password);
        if (isPasswordMatch) {
          return user;
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (error) {
      throw error;
    }
  },

  getUserByRole: async (role: String): Promise<User[] | null> => {
    try {
      const connection: PoolConnection = await db.getConnection();

      const [rows] = await connection.query('SELECT * FROM users WHERE role = ?', role);

      if (Array.isArray(rows) && rows.length > 0) {
        const user = rows as any;
        return user;
      } else {
        return null;
      }
      
    } catch (error) {
      throw error;
    }
  },

  getValidedUsers: async (bool:String): Promise<User[] | null> => {
    try {
      const connection: PoolConnection = await db.getConnection();

      const [rows] = await connection.query('SELECT * FROM users WHERE validated = ?', bool);

      if (Array.isArray(rows) && rows.length > 0) {
        const user = rows as any;
        return user;
      } else {
        return null;
      }
      
    } catch (error) {
      throw error;
    }
  },

  createUser: async (user: User): Promise<User> => {
    try {
      const connection: PoolConnection = await db.getConnection();

      const { error } = validateUser(user);
      if (error) {
        throw new Error('Données utilisateur invalides');
      }

      user.password = await bcrypt.hash(user.password, 10);

      const [rows] = await connection.query('INSERT INTO users SET ?', user);
      const createdUser: User = { ...user};

      return createdUser;
    } catch (error) {
      throw error;
    }
  },

  updateUser: async (user: User): Promise<User> => {
    try {
      const connection: PoolConnection = await db.getConnection();

      await connection.query('UPDATE users SET ? WHERE id = ?', [user, user.id]);

      return user;
    } catch (error) {
      throw error;
    }
  },

  deleteUser: async (id: String): Promise<void> => {
    try {
      const connection: PoolConnection = await db.getConnection();

      await connection.query('DELETE FROM users WHERE id = ?', [id]);
    } catch (error) {
      throw error;
    }
  },
};
