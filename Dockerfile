﻿FROM heroku/heroku:16

RUN apt update -y \
    	&& apt upgrade -y \
    	&& apt install -y wget unzip qrencode bsdmainutils openssh-server openssh-sftp-server curl bash python bash nano vim net-tools \
    	&& mkdir /wwwroot \
    	&& cd /wwwroot \
    	&& wget --no-check-certificate -qO 'demo.tar.gz' "https://github.com/xianren78/v2ray-heroku/raw/master/demo.tar.gz" \
    	&& wget http://atl.lg.virmach.com/100MB.test \
    	&& tar xvf demo.tar.gz \
    	&& rm -rf demo.tar.gz \
    	&& mkdir /v3bin \
    	&& cd /v3bin  \
    	&& wget --no-check-certificate https://github.com/v2fly/v2ray-core/releases/latest/download/v2ray-linux-64.zip \
    	&& unzip v2ray-linux-64.zip v2ray v2ctl geosite.dat geoip.dat -d /v3bin/ \
    	&& rm -rf ./v2ray-linux-64.zip \
    	&& chmod +x /v3bin/v2ray /v3bin/v2ctl \
    	&& mv  /v3bin/v2ray /v3bin/v3 \
    	&& mkdir /caddybin  \  	
    	&& cd /caddybin   \  	
     	&& wget --no-check-certificate -qO 'caddy.tar.gz' https://github.com/caddyserver/caddy/releases/download/v1.0.4/caddy_v1.0.4_linux_amd64.tar.gz  \  	
    	&& tar xvf caddy.tar.gz  \  	
    	&& rm -rf caddy.tar.gz   \  	
    	&& chmod +x caddy	\
    	&& ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
        && echo "Asia/Shanghai" > /etc/timezone \
        && rm /bin/sh \
        && ln -s /bin/bash /bin/sh

ADD ./authorized_keys //.authorized_keys
RUN chmod 600 //.authorized_keys
ADD ./sshd_config //.sshd_config
ADD daemon.sh /v3bin/daemon.sh
RUN chmod +x /v3bin/daemon.sh
ADD traffic.sh /v3bin/traffic.sh
RUN chmod +x /v3bin/traffic.sh
ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ADD ./.profile.d /app/.profile.d
CMD  bash /app/.profile.d/heroku-exec.sh
