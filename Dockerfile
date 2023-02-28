FROM node:alpine
WORKDIR /app
ADD ./app/ /app/
RUN npm install
EXPOSE 3000
CMD ["node", "server.js"]
