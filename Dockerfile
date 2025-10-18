FROM n8nio/n8n:latest

# Root user ile başla
USER root

# Puppeteer-real-browser ve dependencies yükle
RUN npm install -g puppeteer-real-browser && \
    apk add --no-cache chromium nss freetype harfbuzz ca-certificates ttf-freefont xvfb

# Environment variable
ENV NODE_FUNCTION_ALLOW_EXTERNAL=puppeteer-real-browser

# SESSION RESTORE (TAR.GZ ile)
COPY puppeteer-sessions.tar.gz /tmp/
RUN mkdir -p /data/puppeteer-sessions && \
    tar -xzf /tmp/puppeteer-sessions.tar.gz -C /data/ && \
    chown -R node:node /data/puppeteer-sessions && \
    chmod -R 755 /data/puppeteer-sessions && \
    rm -rf /tmp/puppeteer-sessions.tar.gz

# N8N user'a geri dön
USER node
