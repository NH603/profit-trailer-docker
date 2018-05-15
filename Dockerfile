
FROM ubuntu:latest

RUN apt-get update
RUN apt-get install -y unzip wget default-jdk nodejs
RUN ln -s /usr/bin/nodejs /usr/bin/node
RUN apt-get install -y npm
RUN apt-get clean
RUN npm install pm2@latest -g

ARG PT_VERSION=2.0.5
ENV PT_VERSION ${PT_VERSION}

RUN mkdir -p /app
WORKDIR /app

RUN wget https://github.com/taniman/profit-trailer/releases/download/$PT_VERSION/ProfitTrailer-$PT_VERSION.zip
RUN unzip ProfitTrailer-$PT_VERSION.zip 
RUN mv /app/ProfitTrailer-$PT_VERSION /app/ProfitTrailer

WORKDIR /app/ProfitTrailer
RUN chmod +x ProfitTrailer.jar

VOLUME /app/ProfitTrailer

CMD pm2 start pm2-ProfitTrailer.json && pm2 log 0

EXPOSE 8081