export default interface CreateUserDTO{
    id: number;
    practician: number;
    client: number;
    title: string;
    fileUrl: string;
    isValidated: boolean;
    admin: number;
    fileType: fileType;
}