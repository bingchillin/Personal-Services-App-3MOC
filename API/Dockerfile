# Utilisez une image de base avec Node.js préinstallé
FROM node:14-alpine

# Répertoire de travail dans le conteneur
WORKDIR /app

# Copiez les fichiers package.json et package-lock.json
COPY package*.json ./

# Installez les dépendances
RUN npm install --production

# Copiez le reste des fichiers de l'application
COPY . .
COPY dist/index.js /app/

# Port sur lequel l'application écoute
EXPOSE 3000

# Commande pour démarrer l'application
CMD ["npm", "start"]