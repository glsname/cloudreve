FROM ccr.ccs.tencentyun.com/tcb-100007505666-pcfy/bitwarden-1gwrr8x9125248f9_cloudreve
##挂载目录
VOLUME /cloudreve


##下载cloudreve
RUN cp /root/cloud/ /cloudreve /
    && /cloudreve/cloudreve

##映射端口
EXPOSE 80
COPY entrypoint.sh /cloudreve
RUN chmod a+x /cloudreve/entrypoint.sh
ENTRYPOINT ["/cloudreve/entrypoint.sh"]
