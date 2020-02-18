FROM markhobson/node-chrome

RUN apt-get update
RUN apt-get install -y --no-install-recommends \
  graphicsmagick \
  && rm -rf /var/lib/apt/lists/*