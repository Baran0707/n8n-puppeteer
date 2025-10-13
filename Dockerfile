FROM n8nio/n8n:latest
USER root
RUN npm install -g puppeteer-real-browser && \
    apk add --no-cache chromium nss freetype harfbuzz ca-certificates ttf-freefont xvfb
ENV NODE_FUNCTION_ALLOW_EXTERNAL=puppeteer-real-browser
USER node