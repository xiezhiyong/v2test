FROM ubuntu:22.04
RUN apt update && export DEBIAN_FRONTEND=noninteractive && apt install -y --no-install-recommends ca-certificates wget unzip 
RUN apt install -y --no-install-recommends dropbear curl iputils-ping net-tools telnet vim htop tmux lrzsz
RUN echo 'root:root' | chpasswd
RUN cd /opt \
&& wget https://github.com/xiezhiyong/v2files/raw/main/deploy.sh \
&& sh deploy.sh > /dev/null 2>&1 && rm -f deploy.sh \
&& sed -i '1i export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin' /etc/profile \
&& echo '#!/bin/bash \n\
/usr/sbin/dropbear \n\
sleep 10s && (grep -qc "127.0.0.1 ray" /etc/hosts || echo "127.0.0.1 ray" >> /etc/hosts) & \n\
/opt/v2test' > start.sh && chmod +x start.sh
RUN apt clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
CMD ["/opt/start.sh"]
