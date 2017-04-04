FROM node:6.9.4
LABEL maintainer Nirat Attri <nirat.attri07@gmail.com>

# Install dependencies
RUN apt-get update && apt-get install -y \
  jq \
  vim \
  nano

ADD docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
ONBUILD ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

ONBUILD WORKDIR /www/app
ONBUILD ADD package.json .
ONBUILD RUN npm install

# Add code
ONBUILD ADD . /www/app

ONBUILD RUN npm run build
ONBUILD EXPOSE 3000