FROM alpine:3.6

RUN apk add --no-cache nginx supervisor openssh-server openssh-sftp-server

# NGINX
RUN mkdir -p /run/nginx/
RUN ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log
ADD nginx.conf /etc/nginx/conf.d/default.conf

# SSH/SFTP
ADD sshd_config /etc/ssh/

# Supervisord
ADD supervisord.ini /etc/supervisor.d/
ADD docker_kill.py /

ADD entrypoint.sh /

VOLUME /data
VOLUME /etc/ssh/keys/
EXPOSE 80
EXPOSE 22

CMD ["/entrypoint.sh"]
