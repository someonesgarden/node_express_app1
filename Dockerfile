FROM someonesgarden/node_express_base:latest

MAINTAINER 0.1 Daisuke Nishimura d@someonesgarden.org

#RUN bower install angular angular-material \
#angular-messages angular-route \
#angular-resource angular-sanitize \
#angular-local-storage --save

RUN apt-get update -y && \
apt-get install rhino -y

#RUN npm install java -y

RUN bower install d3 --save

RUN npm install cheerio-httpcli request

COPY node_modules /node_modules/
COPY routes /usr/src/app/routes/
COPY public /usr/src/app/public/
COPY views /usr/src/app/views/

EXPOSE 8080

CMD [ "coffee", "bin/www.coffee" ]




