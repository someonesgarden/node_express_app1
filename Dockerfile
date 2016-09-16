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

RUN npm install \
# HTMLファイルの解析用
cheerio cheerio-httpcli \
# XMLの解析用
xml2js \
# ダウンロード処理に利用
request

###
# RUN apt-get install -y libfreetype6-dev libfontconfig1-dev wget bzip2 git python unifont

RUN mkdir /src
WORKDIR /src

# install phantomJS
RUN wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2 &&\
  tar xvf phantomjs-2.1.1-linux-x86_64.tar.bz2 &&\
  mv phantomjs-2.1.1-linux-x86_64/bin/phantomjs /usr/local/bin/

# install casperJS
RUN git clone git://github.com/n1k0/casperjs.git &&\
  mv casperjs /opt/ &&\
  ln -sf /opt/casperjs/bin/casperjs /usr/local/bin/casperjs


####

COPY download.coffee /usr/src/app/download.coffee
COPY funcs.coffee /usr/src/app/funcs.coffee
COPY app.coffee /usr/src/app/app.coffee


COPY routes /usr/src/app/routes/
COPY public /usr/src/app/public/
COPY views /usr/src/app/views/
COPY bin /usr/src/app/bin/


WORKDIR /usr/src/app

EXPOSE 8080

CMD [ "coffee", "bin/www.coffee" ]
#CMD ["phantomjs", "-v"]



