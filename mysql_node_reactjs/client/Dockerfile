FROM node:22.11.0-alpine

ENV NODE_ENV=production

WORKDIR /app

COPY package*.json .

RUN npm install

COPY . .

EXPOSE 3000

ENV API_URL=http://api:5050/api/messages

CMD ["npm", "start"]