FROM node:20

WORKDIR /app

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

COPY ./src/package*.json ./
RUN npm install

COPY ./src /app

EXPOSE 5173

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]