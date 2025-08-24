FROM nginx:alpine

RUN apk add --no-cache curl docker-cli

COPY config/nginx.conf /etc/nginx/conf.d/default.conf
COPY web/ /var/www/html/

RUN chmod -R 755 /var/www/html

EXPOSE 80
