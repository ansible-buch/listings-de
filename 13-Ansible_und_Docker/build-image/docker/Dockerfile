FROM httpd:2.4

RUN apt update && apt install -y libcgi-pm-perl

WORKDIR /usr/local/apache2

COPY app.pl ./cgi-bin/
RUN chmod 755 ./cgi-bin/app.pl

RUN sed -ri 's/#(LoadModule cgid.*)/\1/'     ./conf/httpd.conf
RUN sed -ri 's/#(LoadModule rewrite.*)/\1/'  ./conf/httpd.conf

RUN echo "RewriteEngine On"                        >>./conf/httpd.conf
RUN echo "RewriteRule ^/$ /cgi-bin/app.pl [NC,PT]" >>./conf/httpd.conf
