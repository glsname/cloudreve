FROM centos

RUN yum install -y wget vim unzip \
    && wget  -q -O /root/cloudreve.zip https://scoop.glimmer.ltd/linux/cloudreve/v3.3.1/cloudreve.331.zip \
    && unzip -q /root/cloudreve.zip \
    && rm -rf /root/cloudreve.zip
    
##挂载目录
VOLUME /cloudtemp

##映射端口
EXPOSE 80
EXPOSE 443

COPY entrypoint.sh /cloudtemp
RUN chmod a+x /root/entrypoint.sh
ENTRYPOINT ["/root/entrypoint.sh"]
CMD ["apachectl","-D","FOREGROUND"]
