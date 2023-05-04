import Joi, { ValidationError, ValidationErrorItem } from 'joi';
import IRepository from '../interfaces/IRepository'
import idService from '../services/idService';
import CreateDocDTO from './DTO/createDoc.dto';
import Doc, { IDoc, DocValidationSchema } from './Model';



export class DocsRepository implements IRepository<IDoc, CreateDocDTO> {

    async getAll(): Promise<IDoc[]> {
        return await Doc.find();
    }

    async getOne(id: string): Promise<IDoc | null> {
        return await Doc.findById(id);
    }

    async deleteOne(id: string): Promise<boolean> {
        const doc = Doc.findByIdAndDelete(id);

        if (doc === null) {
            return false;
        }

        return true;
    }

    async createOne(object: CreateDocDTO): Promise<null | ValidationErrorItem[]> {
        const doc = new Doc(object)

        const validationResult = DocValidationSchema.validate(doc)

        if (validationResult.error) {
            return validationResult.error.details
        }

        await doc.save();

        return null;

    }
}

export default new DocsRepository();