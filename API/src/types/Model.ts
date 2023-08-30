import Joi from 'joi';

export interface Type {
    id: number;
    name: string;
}

export const TypeValidationSchema = Joi.object({
    name: Joi.string().required(),
});

export const validateType = (type: Type): Joi.ValidationResult<Type> => {
    return TypeValidationSchema.validate(type, { abortEarly: false });
  };