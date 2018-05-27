FROM alpine:3.7

# Install nginx
RUN apk update && \
    apk add openrc && \
    apk add nginx && \
    adduser -D -g 'www' www && \
    mkdir /www && \ 
    chown -R www:www /var/lib/nginx && \
    chown -R www:www /www && \
    mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.orig
COPY nginx.conf /etc/nginx/nginx.conf
RUN nginx -t

# Install node
#RUN apk add --update nodejs

RUN echo "<html><h1>Docker rulez!!!!</h1></html>" > /www/index.html
COPY index.html /www/
#RUN rc-service nginx restart
EXPOSE 80
CMD ["rc-service", "nginx", "reload"]
#CMD ["npm", "start"]