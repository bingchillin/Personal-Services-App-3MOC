"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = __importDefault(require("express"));
const Controller_1 = __importDefault(require("./users/Controller"));
const authController_1 = __importDefault(require("./auth/authController"));
const app = (0, express_1.default)();
const port = 3000;
app.use(express_1.default.json());
app.get('/', (req, res) => {
    res.send('Hello, World!');
});
app.use("/users", Controller_1.default);
app.use("/login", authController_1.default);
app.listen(process.env.PORT || port, () => {
    console.log('Server started');
});
