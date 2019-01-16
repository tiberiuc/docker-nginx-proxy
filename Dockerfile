FROM nginx:alpine
MAINTAINER Tiberiu Craciun <tibi@happysoft.ro>


RUN apk update \
  && apk add bash \
  && rm -rf /var/cache/apk/* /tmp/* \
  && rm -rf /etc/nginx/conf.d


EXPOSE 80

ADD ./scripts/nginx_entrypoint.sh /usr/local/bin/nginx_entrypoint.sh
ADD ./scripts/default.conf /etc/nginx/conf.d.orig/default.conf
RUN chmod a+x /usr/local/bin/nginx_entrypoint.sh

CMD ["/usr/local/bin/nginx_entrypoint.sh"]
