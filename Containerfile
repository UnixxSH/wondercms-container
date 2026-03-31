FROM rockylinux/rockylinux:10.1-minimal

LABEL maintainer="@UnixxSH"
LABEL description="Run WonderCMS under Rockylinux and httpd/php-fpm"
LABEL org.opencontainers.image.source https://github.com/UnixxSH/wondercms-container

RUN microdnf install -y \
  httpd \
  php \
  php-fpm \
  php-curl \
  php-zip \
  php-mbstring \
  && microdnf clean all

RUN mkdir -p /run/php-fpm /var/www/html/plugins /var/www/html/data

COPY --chmod=700 ./entrypoint.sh /entrypoint.sh
COPY --chmod=755 --chown=apache index.php /var/www/html/index.php
COPY --chmod=755 --chown=apache .htaccess /var/www/html/.htaccess
COPY --chmod=755 --chown=apache themes /var/www/html/themes

RUN chown -R apache:apache /var/www/html

EXPOSE 8080

ENTRYPOINT ["/entrypoint.sh"]