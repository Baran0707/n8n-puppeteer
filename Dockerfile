FROM n8nio/n8n:latest

# Root user ile başla
USER root

# Puppeteer-real-browser ve dependencies yükle
RUN npm install -g puppeteer-real-browser && \
    apk add --no-cache chromium nss freetype harfbuzz ca-certificates ttf-freefont xvfb

# Environment variable
ENV NODE_FUNCTION_ALLOW_EXTERNAL=puppeteer-real-browser

# N8N user'a geri dön
USER node
