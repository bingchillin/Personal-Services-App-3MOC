# Mongoose avec ExpressJS

Mongoose est un ORM pour MongoDB. Il permet de créer des schémas de données, de les valider et de les manipuler.

La mise en place avec docker-compose ayant été vue en cours et dans le slide, on ne va pas s'y attarder.

## Installation

Pour installer mongoose, on installe le package NPM de mongoose et celui des types correspondants pour Typescript.

```bash
npm install mongoose # ou npm i mongoose
npm install --save-dev @types/mongoose # ou npm i -D @types/mongoose
```

## Connexion à la base de données

La connexion se fait via la fonction `mongoose.connect()`.

Pour se connecter, on passe un URL en argument à cette fonction. cet URL a le format suivant :

```text
mongodb://[username:password@]host1[:port1][,host2[:port2],...[,hostN[:portN]]][/[database][?options]]
```

Une bonnne pratique est de rendre la configuration mongo modulaire en utilisant les variables d'environnement. De cette façon on peut gérer les informations sensibles avec les secrets des plateformes de cloud.


```typescript
// src/index.ts ou src/services/mongooseService.ts
import mongoose from 'mongoose';

const mongoUrl = `mongodb://${configService.MONGO_USER
    }:${configService.MONGO_PASSWORD
    }@${configService.MONGO_HOST
    }:${configService.MONGO_PORT
    }/${configService.MONGO_DB
    }`;


mongoose.connect(mongoUrl)
```

## Création d'un schéma

Un schéma est un objet qui décrit la structure d'un document. Il est défini par un objet typescript qui contient les propriétés du document.

Il permet aussi de mettre en place des contraintes assurent une validation du coté de MongoDB.

Voici un exemple de modèle pour un document que l'on utilise aussi comme entité dans notre application.

```typescript
import mongoose, { Document, InferSchemaType } from 'mongoose';

// Les trois seuls roles possibles pour un utilisateur
export type Role = 'admin' | 'user' | 'worker';


// Une interface qui étend Document pour définir les attributs spécifiques à MongoDB tels que _id
export interface IUser extends Document{
    name: string;
    surname: string;
    username: string;
    password: string;
    role: Role;
}

// Un schéma mongoose qui permet de définir les contraintes de validation pour les objets mis en mémoire
export const UserSchema = new mongoose.Schema<IUser>({
    name: { type: String, required: true },
    surname: { type: String, required: true },
    username: { type: String, required: true, unique: true },
    password: { type: String, required: true, default: 'password'}, //noter la possibilité de mettre une valeur par défaut
    role: { type: String, required: true, enum: ['admin', 'user', 'worker'] }, // Noter la possibilité de mettre une liste d'enum
})

export default mongoose.model<IUser>('User', UserSchema)
```

## Manipulation des données

Notre modèle est créé, il serait interessant de pouvoir en stocker des instances. Pour cela, on va créer un repository qui va nous permettre de manipuler `users`.

```typescript
// src/Users/Repository.ts
import User, { IUser } from './User';

export class UsersRepository {
    // récupérer tous les users
    async getAll(): Promise<IUser[]> { 
        // Notez l'utilisation de await pour attendre la fin de l'opération
        return await User.find(); 
    }

    // récupérer un user par son id
    async getOne(id: string): Promise<IUser | null> { 
        // Si l'utilisateur n'existe pas, on findById retourne null
        return await User.findById(id); 
    }

    // récupérer un user par son username
    async getOneByUsername(username: string): Promise<IUser | null> { 
        // On cherche tous les users ayant l'attribut username égal à celui passé en paramètre
        const user = await User.findOne({ username });

        return user;
    }

    // Supprimer un utilisateur par son ID
    async deleteOne(id: string): Promise<boolean> {
        const user = await User.findByIdAndDelete(id);

        // Si aucun utilisateur a été trouvé, findByIdAndDelete retourne null
        if (!user) { 
            return false;
        }

        return true;
    }

    // Créer un utilisateur
    async createOne(object: IUser): Promise<IUser> {
        // on crée une instance de user en utilisant le modèle fourni par mongoose
        const user = new User(object);

        // On save ce modèle avec la methode save() de mongoose
        await user.save();

        return;
    }
}
```

## Utilisation du repository

On peut maintenant utiliser notre repository dans notre controller pour manipuler les données.

```typescript
// src/Users/Controller.ts

usersController.get("/:id", async (req, res) => {
    const user = await usersRepository.getOne(req.params.id);

    if (!user) {
        res.status(404).send({
            status: 404,
            message: "Not found"
        })
        return
    }

    res.status(200).send(user)
})


usersController.post("/", async (req, res) => {
    const user = await usersRepository.createOne(req.body);

    res.status(201).send(user)
})

usersController.delete("/:id", async (req, res) => {
    const deleted = await usersRepository.deleteOne(req.params.id);

    if (!deleted) {
        res.status(404).send({
            status: 404,
            message: "Not found"
        })
        return
    }

    res.status(200).send({
        status: 200,
        message: "Deleted"
    })
})
```


