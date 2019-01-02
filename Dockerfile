FROM node:10-alpine

RUN mkdir -p /usr/src/svc && apk add --no-cache bash curl

WORKDIR /usr/src/svc
COPY . /usr/src/svc

EXPOSE 8080

RUN npm install
RUN npm audit fix
RUN npm rebuild
CMD npm run serve
