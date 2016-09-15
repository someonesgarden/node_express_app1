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

RUN npm install casperjs cheerio cheerio-httpcli request

COPY download.coffee /usr/src/app/download.coffee
COPY funcs.coffee /usr/src/app/funcs.coffee
COPY app.coffee /usr/src/app/app.coffee


COPY routes /usr/src/app/routes/
COPY public /usr/src/app/public/
COPY views /usr/src/app/views/
COPY bin /usr/src/app/bin/



EXPOSE 8080

CMD [ "coffee", "bin/www.coffee" ]




