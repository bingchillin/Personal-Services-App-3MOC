"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.UserRepository = void 0;
const Model_1 = require("./Model");
const mysql_1 = __importDefault(require("../services/mysql"));
exports.UserRepository = {
    getAll: () => __awaiter(void 0, void 0, void 0, function* () {
        try {
            const connection = yield mysql_1.default.getConnection();
            const [rows] = yield connection.query('SELECT * FROM users');
            //if (Array.isArray(rows) && rows.length > 0) {
            const user = rows;
            //debug(user);
            return user;
            //} else {
            //return null;
            //}
        }
        catch (error) {
            throw error;
        }
    }),
    createUser: (user) => __awaiter(void 0, void 0, void 0, function* () {
        try {
            const connection = yield mysql_1.default.getConnection();
            const { error } = (0, Model_1.validateUser)(user);
            if (error) {
                throw new Error('Données utilisateur invalides');
            }
            const [rows] = yield connection.query('INSERT INTO users SET ?', user);
            const createdUser = Object.assign({}, user);
            return createdUser;
        }
        catch (error) {
            throw error;
        }
    }),
    getUserById: (id) => __awaiter(void 0, void 0, void 0, function* () {
        try {
            const connection = yield mysql_1.default.getConnection();
            const [rows] = yield connection.query('SELECT * FROM users WHERE id = ?', [id]);
            if (Array.isArray(rows) && rows.length > 0) {
                const user = rows[0];
                return user;
            }
            else {
                return null;
            }
        }
        catch (error) {
            throw error;
        }
    }),
    getUserByEmail: (email) => __awaiter(void 0, void 0, void 0, function* () {
        try {
            const connection = yield mysql_1.default.getConnection();
            const [rows] = yield connection.query('SELECT * FROM users WHERE email = ?', [email]);
            if (Array.isArray(rows) && rows.length > 0) {
                const user = rows[0];
                return user;
            }
            else {
                return null;
            }
        }
        catch (error) {
            throw error;
        }
    }),
    getUserByLogs: (email, password) => __awaiter(void 0, void 0, void 0, function* () {
        try {
            const connection = yield mysql_1.default.getConnection();
            const [rows] = yield connection.query('SELECT * FROM users WHERE email = ? AND password = ?', [email, password]);
            if (Array.isArray(rows) && rows.length > 0) {
                const user = rows[0];
                return user;
            }
            else {
                return null;
            }
        }
        catch (error) {
            throw error;
        }
    }),
    updateUser: (user) => __awaiter(void 0, void 0, void 0, function* () {
        try {
            const connection = yield mysql_1.default.getConnection();
            yield connection.query('UPDATE users SET ? WHERE id = ?', [user, user.id]);
            return user;
        }
        catch (error) {
            throw error;
        }
    }),
    deleteUser: (id) => __awaiter(void 0, void 0, void 0, function* () {
        try {
            const connection = yield mysql_1.default.getConnection();
            yield connection.query('DELETE FROM users WHERE id = ?', [id]);
        }
        catch (error) {
            throw error;
        }
    }),
};
