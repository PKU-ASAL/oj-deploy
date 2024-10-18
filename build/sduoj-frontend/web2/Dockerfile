FROM alpine AS downloader

RUN wget -O /web2.zip https://codeload.github.com/SDUOJ/sduoj-web2/zip/gh-pages \
 && unzip -o -q -d / /web2.zip \
 && mv /sduoj-web* /sduoj-web2 \

FROM nginx

COPY --from=downloader /sduoj-web2 /app

EXPOSE 80
