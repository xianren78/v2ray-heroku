FROM debian:stretch-slim

RUN apt update -y \
    	&& apt upgrade -y \
    	&& apt install -y wget unzip qrencode tzdata

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
CMD /entrypoint.sh
