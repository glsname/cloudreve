FROM alpine:3.2
ENV cloudreve_URL https://github.com/glsname/cloudreve/releases/download/3.3.1/cloudreve.3.3.1.zip

##挂载目录
VOLUME /cloudreve


##下载cloudreve
RUN yum install -y --no-install-recommends unzip wget  \
    && wget -q -O /cloudreve/cloudreve.3.3.1.zip ${cloudreve_URL} \
    && unzip -q /cloudreve/cloudreve.3.3.1.zip -d /cloudreve/ \ 
    && rm /cloudreve/cloudreve.3.3.1.zip \
    && /cloudreve/cloudreve

##映射端口
EXPOSE 80
COPY entrypoint.sh /cloudreve
RUN chmod a+x /cloudreve/entrypoint.sh
ENTRYPOINT ["/cloudreve/entrypoint.sh"]
