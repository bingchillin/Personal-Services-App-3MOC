import Joi from 'joi';
import { Document, InferSchemaType } from 'mongoose';
import mongoose from '../services/mongooseService';

export type Role = 'admin' | 'client' | 'worker' | 'medicWorker';
export type Profession = 'admin' | 'client' | 'worker' | 'medicWorker';

export interface IUser extends Document{
    id: number;
    email: string;
    password: string;
    lastName: string;
    firstName: string;
    birthdate: Date;
    isValidated: boolean;
    note: number;
    profession: Profession;
    role: Role;
}

export const UserValidationSchema = Joi.object({
    id: Joi.number().required(),
    email: Joi.string().required(),
    password: Joi.string().required(),
    lastName: Joi.string().required(),
    firstName: Joi.string().required(),
    birthdate: Joi.date().required(),
    isValidated: Joi.boolean().required(),
    profession: Joi.string().valid('admin', 'client', 'worker', 'medicWorker'),
    role: Joi.string().valid('admin', 'client', 'worker', 'medicWorker').required(),
});

export const UserSchema = new mongoose.Schema<IUser>({
    id: {type: Number, required: true, unique: true },
    email: { type: String, required: true, unique: true },
    password: { type: String, required: true },
    lastName: { type: String, required: true},
    firstName: { type: String, required: true },
    birthdate: { type: Date, required: true },
    isValidated: { type: Boolean, required: true },
    profession: { type: String, enum: ['admin', 'client', 'worker', 'medicWorker'] },
    role: { type: String, required: true, enum: ['admin', 'client', 'worker', 'medicWorker'] },
})

export default mongoose.model<IUser>('User', UserSchema)
