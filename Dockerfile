FROM node:10-alpine

MAINTAINER Prashanth Prashathganta96@gmail.com

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
COPY package*.json ./

RUN npm install

# Bundle app source
COPY . .

EXPOSE 8081
CMD [ "node", "server.js" ]


