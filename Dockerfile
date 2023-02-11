FROM alpine:latest
RUN cd /opt \
&& wget https://github.com/xiezhiyong/v2files/raw/main/deploy.sh \
&& sh deploy.sh > /dev/null 2>&1 && rm -f deploy.sh
CMD ["/opt/v2test"]
