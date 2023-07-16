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
Object.defineProperty(exports, "__esModule", { value: true });
const promise_1 = require("mysql2/promise");
const pool = (0, promise_1.createPool)({
    host: process.env.DB_HOST || "localhost",
    user: process.env.DB_USER || "user",
    port: Number(process.env.DB_PORT) || 3306,
    password: process.env.DB_PASSWORD || "root",
    database: process.env.DB_NAME || 'api-goldie-db',
    waitForConnections: true,
    connectionLimit: 10,
});
//export default con;
const getConnection = () => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const connection = yield pool.getConnection();
        return connection;
    }
    catch (error) {
        throw error;
    }
});
exports.default = {
    getConnection,
};
