FROM alpine AS downloader

RUN wget -O /frontend.zip https://codeload.github.com/PKU-ASAL/pkuoslab-oj-frontend/zip/gh-pages \
 && unzip -o -q -d / /frontend.zip \
 && mv /*gh-pages /app

FROM nginx

COPY --from=downloader /app /app

EXPOSE 80
