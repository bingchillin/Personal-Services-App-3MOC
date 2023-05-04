import { fileType } from "../Model";

export default interface CreateDocDTO{
    id: number;
    practician: number;
    client: number;
    title: string;
    fileUrl: string;
    isValidated: boolean;
    admin: number;
    fileType: fileType;
}