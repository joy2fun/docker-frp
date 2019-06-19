FROM alpine:latest

ENV  VER=0.27.0

RUN apk add --no-cache --virtual .build-deps ca-certificates curl\
 && mkdir -m 777 /frp \
 && cd /frp \
 && curl -L -H "Cache-Control: no-cache" -o frp.tar.gz https://github.com/fatedier/frp/releases/download/v$VER/frp_${VER}_linux_amd64.tar.gz \
 && tar -zxvf frp.tar.gz \
 && mv /frp/frp_${VER}_linux_amd64/frpc /frp/ \
 && rm -f /frp/frp.tar.gz \
 && rm -rf /frp/frp_${VER}_linux_amd64 \
 && chmod +x /frp/frpc \
 && chgrp -R 0 /frp \
 && chmod -R g+rwX /frp

CMD ["sh","-c","/frp/frpc -c /frp/frpc.ini"] 
