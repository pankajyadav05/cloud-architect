# Stage 1: Build the React app
FROM node:20 AS build

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run test

RUN npm run build


# Stage 2: Serve the React app with nginx
FROM nginx:alpine

# Remove the default nginx static files
RUN rm -rf /usr/share/nginx/html/*

# Copy the built React app from the build stage
COPY --from=build /app/build /usr/share/nginx/html

# Start nginx server
ENTRYPOINT ["nginx", "-g", "daemon off;"]
