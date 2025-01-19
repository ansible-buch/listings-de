FROM httpd:2.4

RUN apt update && apt install -y python3-flask

WORKDIR /usr/local/apache2

COPY app.py ./cgi-bin/
RUN chmod 755 ./cgi-bin/app.py

RUN sed -ri 's/#(LoadModule cgid.*)/\1/'     ./conf/httpd.conf
RUN sed -ri 's/#(LoadModule rewrite.*)/\1/'  ./conf/httpd.conf

RUN echo "RewriteEngine On"                        >>./conf/httpd.conf
RUN echo "RewriteRule ^/$ /cgi-bin/app.py [NC,PT]" >>./conf/httpd.conf
