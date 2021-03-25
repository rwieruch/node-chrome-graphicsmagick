FROM node:15.12 AS base

# GM

RUN apt-get update
RUN apt-get install -y --no-install-recommends \
  graphicsmagick \
  && rm -rf /var/lib/apt/lists/*

# Chrome

RUN echo 'deb http://dl.google.com/linux/chrome/deb/ stable main' > /etc/apt/sources.list.d/chrome.list

RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -

RUN set -x \
  && apt-get update \
  && apt-get install -y \
  google-chrome-stable

ENV CHROME_BIN /usr/bin/google-chrome

# Install Docker

RUN apt-get update && \
  apt-get -y install apt-transport-https \
  ca-certificates \
  curl \
  gnupg2 \
  software-properties-common && \
  curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg > /tmp/dkey; apt-key add /tmp/dkey && \
  add-apt-repository \
  "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
  $(lsb_release -cs) \
  stable" && \
  apt-get update && \
  apt-get -y install docker-ce

# Log versions

RUN set -x \
  && node -v \
  && npm -v \
  && docker --version
