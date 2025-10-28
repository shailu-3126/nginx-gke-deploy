# frontend/Dockerfile - build React (Vite) then serve with nginx
FROM node:18-alpine AS build
WORKDIR /app

# copy only package.json and install (avoid requiring package-lock.json)
COPY package.json ./
RUN npm install --no-audit --no-fund

# copy source and build
COPY . .
RUN npm run build

# production nginx stage
FROM nginx:stable-alpine
COPY nginx.conf /etc/nginx/conf.d/default.conf
# Vite outputs to /dist by default; adjust if your build uses /build
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
