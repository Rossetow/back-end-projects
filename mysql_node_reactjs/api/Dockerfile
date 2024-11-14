FROM node:22.11.0-alpine AS build

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

FROM node:22.11.0-alpine

WORKDIR /app

COPY --from=build /app /app

EXPOSE 5050

CMD ["npm", "start"]
