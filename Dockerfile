FROM ubuntu:18.10

ENV APP_DIR /app
ENV HUGO_VERSION 0.50

RUN apt-get -y update && \
    apt-get -y upgrade

ADD https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.deb /tmp/hugo.deb
RUN dpkg -i /tmp/hugo.deb && \
    rm /tmp/hugo.deb

RUN useradd -d ${APP_DIR} -m -u 1000 developer

EXPOSE 8000
USER developer
WORKDIR ${APP_DIR}

CMD hugo server -D --bind 0.0.0.0 -p 8000
