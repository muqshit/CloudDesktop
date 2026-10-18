FROM mcr.microsoft.com/vscode/devcontainers/base:ubuntu

ENV DEBIAN_FRONTEND=noninteractive
ENV DISPLAY=:1

RUN apt-get update && apt-get install -y \
    xfce4 \
    xfce4-goodies \
    dbus-x11 \
    xvfb \
    x11vnc \
    novnc \
    supervisor \
    firefox \
    thunar \
    xfce4-terminal \
    mousepad \
    curl \
    wget \
    git \
    nano \
    sudo \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY start-desktop.sh /usr/local/bin/start-desktop.sh
COPY supervisord.conf /etc/supervisor/conf.d/cloudpc.conf

RUN chmod +x /usr/local/bin/start-desktop.sh

RUN mkdir -p /var/log/supervisor /var/run/supervisor

EXPOSE 6080

CMD ["/usr/bin/supervisord", "-n"]
