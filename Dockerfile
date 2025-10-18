FROM n8nio/n8n:latest

# Root user ile başla
USER root

# Puppeteer-real-browser ve dependencies yükle (AYNI KALDI)
RUN npm install -g puppeteer-real-browser && \
    apk add --no-cache chromium nss freetype harfbuzz ca-certificates ttf-freefont xvfb unzip

# Environment variable (AYNI KALDI)
ENV NODE_FUNCTION_ALLOW_EXTERNAL=puppeteer-real-browser

# 🆕 SESSION RESTORE MANTĞI (YENİ EKLENEN KISIM)
COPY puppeteer-sessions.zip /tmp/
RUN mkdir -p /data/puppeteer-sessions && \
    cd /tmp && \
    unzip -q puppeteer-sessions.zip -d /tmp/ && \
    cp -r /tmp/puppeteer-sessions/* /data/puppeteer-sessions/ && \
    chown -R node:node /data/puppeteer-sessions && \
    chmod -R 755 /data/puppeteer-sessions && \
    rm -rf /tmp/puppeteer-sessions.zip /tmp/puppeteer-sessions

# N8N user'a geri dön (AYNI KALDI)
USER node
