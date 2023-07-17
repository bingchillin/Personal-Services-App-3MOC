"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.validateUser = exports.UserValidationSchema = void 0;
const joi_1 = __importDefault(require("joi"));
exports.UserValidationSchema = joi_1.default.object({
    email: joi_1.default.string().email().required(),
    password: joi_1.default.string().required(),
    lastname: joi_1.default.string().required(),
    firstname: joi_1.default.string().required(),
    birthdate: joi_1.default.date().required(),
    profession: joi_1.default.number().required(),
    role: joi_1.default.number().required()
});
const validateUser = (user) => {
    return exports.UserValidationSchema.validate(user, { abortEarly: false });
};
exports.validateUser = validateUser;
