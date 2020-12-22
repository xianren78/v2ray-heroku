FROM heroku/heroku:16

RUN apt update -y \
    	&& apt upgrade -y \
    	&& apt install -y wget unzip qrencode bsdmainutils openssh-server openssh-sftp-server curl python bash nano vim net-tools \
    	&& mkdir /wwwroot \
    	&& cd /wwwroot \
    	&& wget --no-check-certificate -qO 'demo.tar.gz' "https://github.com/xianren78/v2ray-heroku/raw/master/demo.tar.gz" \
    	&& dd if=/dev/urandom of=100MB.test count=100 bs=1024 \
    	&& tar xvf demo.tar.gz \
    	&& rm -rf demo.tar.gz \
    	&& mkdir /v3bin \
    	&& cd /v3bin  \
    	&& wget --no-check-certificate https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip \
    	&& wget --no-check-certificate https://github.com/v2fly/v2ray-core/releases/download/v4.32.1/v2ray-linux-64.zip \
    	&& unzip Xray-linux-64.zip xray  geosite.dat geoip.dat -d /v3bin/ \
        && unzip v2ray-linux-64.zip v2ctl -d /v3bin/ \
    	&& rm -rf ./Xray-linux-64.zip \
    	&& rm -rf ./v2ray-linux-64.zip \
    	&& chmod +x /v3bin/xray /v3bin/v2ctl \
    	&& mv  /v3bin/xray /v3bin/x \
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

ADD ./authorized_keys /etc/ssh/authorized_keys
RUN chmod 644 /etc/ssh/authorized_keys
ADD ./go.sh /wwwroot/go.sh
ADD ./sshd_config /etc/ssh/sshd_config
ADD daemon.sh /v3bin/daemon.sh
RUN chmod +x /v3bin/daemon.sh
ADD traffic.sh /v3bin/traffic.sh
RUN chmod +x /v3bin/traffic.sh
ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ADD ./.profile.d /app/.profile.d
CMD  bash /app/.profile.d/heroku-exec.sh
