import Joi from 'joi';

export interface TypeTask {
    id: number;
    name: string;
}

export const TypeTaskValidationSchema = Joi.object({
    name: Joi.string().required(),
});

export const validateTypeTask = (typeTask: TypeTask): Joi.ValidationResult<TypeTask> => {
    return TypeTaskValidationSchema.validate(typeTask, { abortEarly: false });
  };