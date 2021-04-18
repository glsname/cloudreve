FROM glsname/cloudreve
##挂载目录
VOLUME /cloudtemp


##下载cloudreve
RUN cp /root/cloudreve /cloudtemp /
    && cp /root/cloudreve.db /cloudtemp /
    && cp /root/conf.ini /cloudtemp

##映射端口
EXPOSE 80
COPY entrypoint.sh /cloudtemp
RUN chmod a+x /cloudtemp/entrypoint.sh
ENTRYPOINT ["/cloudtemp/entrypoint.sh"]
