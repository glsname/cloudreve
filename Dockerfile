FROM centos

RUN rm -f /etc/localtime \
&& ln -sv /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
&& echo "Asia/Shanghai" > /etc/timezone

RUN yum install -y wget vim unzip \
    && wget  -q -O /root/cloudreve.zip https://scoop.glimmer.ltd/linux/cloudreve/v3.3.1/cloudreve.331.zip \
    && unzip -q /root/cloudreve.zip \
    && rm -rf /root/cloudreve.zip \
    && mkdir /cloudtemp && chown -R www-data:root /cloudtemp && chmod -R g=u /cloudtemp
    
##挂载目录
VOLUME /cloudtemp

##映射端口
EXPOSE 80 443

COPY entrypoint.sh /root
RUN chmod a+x /root/entrypoint.sh
CMD ["sh","-c","/root/entrypoint.sh"]
