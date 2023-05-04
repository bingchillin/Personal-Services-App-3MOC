import Joi from 'joi'
import Room from '../IdentityFile/Model';
import User  from '../Users/Model';
import mongoose from '../services/mongooseService';

export interface IReservation extends Document {
    dateStart: Date;
    dateEnd: Date;
    price: number;
    cancelled: boolean;
    userId: string;
    roomId: string;
}

export const ReservationValidationSchema = Joi.object({
    dateEnd: Joi.date().required(),
    dateStart: Joi.date().required(),
    price: Joi.number().positive().optional(),
    cancelled: Joi.boolean().optional(),
    userId: Joi.string().required().uuid(),
    roomId: Joi.string().required().uuid()
})

export const ReservationSchema = new mongoose.Schema({
    dateStart: { type: Date, required: true },
    dateEnd: { type: Date, required: true },
    price: { type: Number, required: true },
    cancelled: { type: Boolean, required: true, default: false },
    userId: { type: String, required: true, ref: User },
    roomId: { type: String, required: true, ref: Room }
})

export default mongoose.model<IReservation>('Reservation', ReservationSchema);

