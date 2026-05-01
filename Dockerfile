# En kararlı Node v20 tabanlı n8n sürümü
FROM docker.io/n8nio/n8n:1.80.0

USER root

# Paket listesini güncelle ve Chromium bağımlılıklarını kur
RUN apk add --no-cache \
    chromium \
    nss \
    freetype \
    harfbuzz \
    ca-certificates \
    ttf-freefont \
    xvfb \
    git

# Paketini global olarak kur
RUN npm install -g puppeteer-real-browser

# Puppeteer için gerekli çevre değişkenleri
ENV NODE_FUNCTION_ALLOW_EXTERNAL=puppeteer-real-browser
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser

USER node
