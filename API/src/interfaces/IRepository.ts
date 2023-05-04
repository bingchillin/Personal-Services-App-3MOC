import { ValidationError, ValidationErrorItem } from "joi";

export default interface Repository<T, CREATE_DTO_T> {
    getAll(): Promise<T[]>;
    getOne(id: string): Promise<T | null>;
    deleteOne(id: string): Promise<boolean>;
    createOne(object: CREATE_DTO_T): Promise<null | ValidationErrorItem[]>;
}