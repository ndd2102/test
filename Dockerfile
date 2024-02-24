FROM node:19-alpine3.16
WORKDIR /app
COPY package.json .
COPY package-lock.json .
RUN npm i
COPY . .
#Expose the React.js application container on port 3000
EXPOSE 3000
#The command to start the React.js application container
CMD ["npm", "start"]