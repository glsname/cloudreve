from centos

VOLUME /cloudreve

RUN yum install wget unzip -y \
	&& rm -rf /var/cache/yum/* \
	&& cd /root \
	&& wget --tries=3 https://scoop.glimmer.ltd/linux/cloudreve/v3.3.1/cloudreve331.zip \
	&& unzip cloudreve331.zip \
	&& chmod 777 ./start.sh


EXPOSE 80
EXPOSE 443

CMD /root/start.sh
