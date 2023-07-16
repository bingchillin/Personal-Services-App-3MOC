import Joi from 'joi';

export interface File {
    id?: number;
    user_id: number;
    title: string;
    file: string;
    validated: boolean;
    type: number;
}

export const FileValidationSchema = Joi.object({
    id: Joi.number().optional(),
    user_id: Joi.number().required(),
    title: Joi.string().required(),
    file: Joi.string().required(),
    validated: Joi.boolean().required(),
    type: Joi.number().required()
});

export const validateFile = (file: File): Joi.ValidationResult<File> => {
    return FileValidationSchema.validate(file, { abortEarly: false });
  }