FROM ccr.ccs.tencentyun.com/smyt/nginx_proxy_server
ENV cloudreve_URL https://scoop.glimmer.ltd/linux/cloudreve/v3.3.1/cloudreve_3.3.1_linux_amd64.tar.gz

# 设置nginx反代及创建目录
RUN echo -e 'server {\n' \
'    listen       80;\n' \
'    server_name  localhost;\n' \
'    location / {\n' \
'        proxy_set_header Host $host;\n' \
'        proxy_redirect off;\n' \
'        proxy_set_header X-Real-IP $remote_addr;\n' \
'        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;\n' \
'        proxy_connect_timeout 60;\n' \
'        proxy_read_timeout 600;\n' \
'        proxy_send_timeout 600;\n' \
'        proxy_pass http://127.0.0.1:5212;\n' \
'    }\n' \
'}\n' \ > /etc/nginx/conf.d/default.conf \
    && nginx -s reload \
    && mkdir /cloudreve 

##挂载目录
VOLUME /cloudreve


##下载cloudreve
RUN apt-get update && apt-get install -y --no-install-recommends wget  \
    && wget -q -O /cloudreve/cloudreve_3.3.1_linux_amd64.tar.gz ${cloudreve_URL} \
    && tar -zxvf /cloudreve/cloudreve_3.3.1_linux_amd64.tar.gz \ 
    && rm /cloudreve/cloudreve_3.3.1_linux_amd64.tar.gz

##映射端口
EXPOSE 80
COPY entrypoint.sh /cloudreve
RUN chmod a+x /cloudreve/entrypoint.sh
ENTRYPOINT ["/cloudreve/entrypoint.sh"]