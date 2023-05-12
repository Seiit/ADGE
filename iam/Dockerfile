# Usa una imagen de Node.js como base
FROM node:lts

# Establece el directorio de trabajo de la aplicación en /app
WORKDIR /usr/src/app

# Copia el archivo package.json a la imagen
COPY package.json .

# Instala las dependencias de la aplicación
RUN npm install --quiet

# Copia el código fuente de la aplicación a la imagen
COPY . .

# Expone el puerto 3000 para que la aplicación pueda ser accedida desde fuera del contenedor
EXPOSE 3000

# Inicia la aplicación
CMD ["npm", "run" , "dev"]
