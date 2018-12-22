FROM mhart/alpine-node

WORKDIR /server

EXPOSE 80

COPY /server /server

RUN yarn

CMD yarn start-server