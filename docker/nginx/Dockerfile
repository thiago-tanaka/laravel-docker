FROM nginx:1.10

ADD vhost.conf /etc/nginx/conf.d/default.conf
ADD max_size.conf /etc/nginx/conf.d/max_size.conf
RUN apt-get update
RUN apt-get install nano
