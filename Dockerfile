# # syntax=docker/dockerfile:1

# ARG NODE_VERSION=24.11.0
# FROM node:${NODE_VERSION}-alpine

# # Set environment to development (so devDependencies are installed)
# ENV NODE_ENV development

# WORKDIR /usr/src/app

# # Copy package files first for caching
# COPY package*.json ./

# # Install ALL dependencies (including dev)
# RUN npm install

# # Copy the rest of the project files
# COPY . .

# # Expose frontend dev port (Vite default)
# EXPOSE 5173

# # Run the development server
# CMD npm run dev

# 1 — Build Stage
FROM node:24-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# 2 — Serve Stage (nginx)
FROM nginx:alpine
COPY --from=builder /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]