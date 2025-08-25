# Étape 1 : builder l'application Angular
FROM node:22 AS builder

WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build -- --configuration production

# Étape 2 : servir avec Nginx
FROM nginx:alpine
COPY --from=builder /app/dist/demo-angular /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
