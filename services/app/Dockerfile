# Stage 1 build vite

FROM node:20-alpine AS builder

WORKDIR /app

COPY package*.json ./

RUN --mount=type=cache,target=/root/.npm npm ci

COPY . .

RUN npm run build


# Stage 2 - Serve

FROM nginx:1.25-alpine

COPY --from=builder /app/dist/ /usr/share/nginx/html

EXPOSE 80



