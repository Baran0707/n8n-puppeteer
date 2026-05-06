FROM ghcr.io/n8n-io/n8n:1.93.0
USER root
RUN ARCH=$(uname -m) && \
    wget -qO- "http://dl-cdn.alpinelinux.org/alpine/latest-stable/main/${ARCH}/" | \
    grep -o 'href="apk-tools-static-[^"]*\.apk"' | head -1 | cut -d'"' -f2 | \
    xargs -I {} wget -q "http://dl-cdn.alpinelinux.org/alpine/latest-stable/main/${ARCH}/{}" && \
    tar -xzf apk-tools-static-*.apk && \
    ./sbin/apk.static --initdb add apk-tools && \
    rm -f apk-tools-static-*.apk
RUN apk add --no-cache chromium nss freetype harfbuzz ca-certificates ttf-freefont xvfb
RUN npm install -g puppeteer-real-browser
ENV NODE_FUNCTION_ALLOW_EXTERNAL=puppeteer-real-browser
USER node
