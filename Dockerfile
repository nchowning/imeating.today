FROM nginx:stable

ENV APP_DIR /app
COPY . ${APP_DIR}
ENV HUGO_VERSION 0.50

RUN echo "#### Update container" && \
    apt-get -y update && \
    apt-get -y upgrade

ADD https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.deb /tmp/hugo.deb
RUN echo "#### Install hugo" && \
    dpkg -i /tmp/hugo.deb && \
    rm /tmp/hugo.deb

RUN echo "#### Building site" && \
    hugo -s ${APP_DIR} -d /usr/share/nginx/html && \
    echo "#### Cleanup..." && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get remove -y hugo && \
    rm -rf /app
