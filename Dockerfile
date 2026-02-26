FROM ghcr.io/n8n-io/n8n:latest

USER root

# apk kaldırılmış, önce geri yüklüyoruz
RUN ARCH=$(uname -m) && \
    wget -qO- "http://dl-cdn.alpinelinux.org/alpine/latest-stable/main/${ARCH}/" | \
    grep -o 'href="apk-tools-static-[^"]*\.apk"' | head -1 | cut -d'"' -f2 | \
    xargs -I {} wget -q "http://dl-cdn.alpinelinux.org/alpine/latest-stable/main/${ARCH}/{}" && \
    tar -xzf apk-tools-static-*.apk && \
    ./sbin/apk.static --initdb add apk-tools && \
    rm -f apk-tools-static-*.apk

# Artık apk çalışıyor, chromium ve bağımlılıkları kur
RUN apk add --no-cache chromium nss freetype harfbuzz ca-certificates ttf-freefont xvfb

# puppeteer-real-browser - aynen korunuyor
RUN npm install -g puppeteer-real-browser

ENV NODE_FUNCTION_ALLOW_EXTERNAL=puppeteer-real-browser
USER node
