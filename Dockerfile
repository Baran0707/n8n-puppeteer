FROM ghcr.io/n8n-io/n8n:latest

USER root
RUN npm install -g puppeteer-real-browser && \
    apt-get update && apt-get install -y --no-install-recommends \
    chromium nss libfreetype6 libharfbuzz0b ca-certificates fonts-freefont-ttf xvfb \
    && rm -rf /var/lib/apt/lists/*
ENV NODE_FUNCTION_ALLOW_EXTERNAL=puppeteer-real-browser
USER node
