import Joi from 'joi';

export interface Task {
    id: number;
    user_id: number;
    title: string;
    type: number;
    content: string;
}

export const TaskValidationSchema = Joi.object({
    title: Joi.string().required(),
    user_id: Joi.number().required(),
    type: Joi.number().required(),
    content: Joi.string().required(),
});

export const validateTask = (task: Task): Joi.ValidationResult<Task> => {
    return TaskValidationSchema.validate(task, { abortEarly: false });
  };