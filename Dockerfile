FROM node:14

WORKDIR /app

COPY package.json .

COPY . . 

RUN npm install

EXPOSE 3000

CMD ["node","src/login.js"]