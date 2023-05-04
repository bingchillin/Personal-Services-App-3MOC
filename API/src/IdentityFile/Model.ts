import Joi from "joi";
import mongoose from "../services/mongooseService";

export type fileType = 'identity' | 'graduation' | 'medicalNeeds';

export interface IDoc extends mongoose.Document {
    id: number;
    practician: number;
    client: number;
    title: string;
    fileUrl: string;
    isValidated: boolean;
    admin: number;
    fileType: fileType;
}

export const DocValidationSchema = Joi.object({
    id: Joi.number().required(),
    practician: Joi.number().required(),
    client: Joi.number().required(),
    title: Joi.string().required(),
    fileUrl: Joi.string().required(),
    isValidated: Joi.boolean().required(),
    admin: Joi.number().required(),
    fileType: Joi.string().valid('identity' , 'graduation' , 'medicalNeeds').required(),
})

export const DocSchema = new mongoose.Schema({
    id: { type: Number, required: true , unique: true},
    practician: { type: Number, required: true },
    client: { type: Number, required: true},
    title: { type: String, required: true},
    fileUrl: { type: String, required: true},
    isValidated: { type: String, required: true},
    admin: { type: String, required: true},
    fileType: { type: String, required: true, enum: ['identity' , 'graduation' , 'medicalNeeds'] },
})

export default mongoose.model<IDoc>('Doc', DocSchema);