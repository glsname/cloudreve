FROM ccr.ccs.tencentyun.com/tcb_public/php:7.3-apache
ENV cloudreve_URL https://github.com/glsname/cloudreve/releases/download/3.3.1/cloudreve.3.3.1.zip
##安装相关拓展
RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        exiftool \
  && docker-php-ext-install -j$(nproc) iconv \
  && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
  && docker-php-ext-install -j$(nproc) gd \
  && docker-php-ext-install exif \
  && docker-php-ext-configure exif --enable-exif \
  && docker-php-ext-install pdo pdo_mysql \
  && cd /usr/local/bin && ./docker-php-ext-install mysqli \
  && rm -rf /var/cache/apk/*
# set recommended PHP.ini settings
# see https://docs.nextcloud.com/server/12/admin_manual/configuration_server/server_tuning.html#enable-php-opcache
RUN { \
        echo 'opcache.enable=1'; \
        echo 'opcache.interned_strings_buffer=8'; \
        echo 'opcache.max_accelerated_files=10000'; \
        echo 'opcache.memory_consumption=128'; \
        echo 'opcache.save_comments=1'; \
        echo 'opcache.revalidate_freq=1'; \
    } > /usr/local/etc/php/conf.d/opcache-recommended.ini; \
    \
    echo 'apc.enable_cli=1' >> /usr/local/etc/php/conf.d/docker-php-ext-apcu.ini; \
    \
    echo 'memory_limit=512M' > /usr/local/etc/php/conf.d/memory-limit.ini;
##挂载目录
VOLUME /cloudreve


##下载cloudreve
RUN apt-get update && apt-get install -y --no-install-recommends unzip ca-certificates wget  \
    && wget -q -O /cloudreve/cloudreve.3.3.1.zip ${cloudreve_URL} \
    && unzip -q /cloudreve/cloudreve.3.3.1.zip -d /cloudreve/ \ 
    && rm /cloudreve/cloudreve.3.3.1.zip \
    && /cloudreve/cloudreve

##映射端口
EXPOSE 80
COPY entrypoint.sh /cloudreve
RUN chmod a+x /cloudreve/entrypoint.sh
ENTRYPOINT ["/cloudreve/entrypoint.sh"]
