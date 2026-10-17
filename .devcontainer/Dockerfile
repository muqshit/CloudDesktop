FROM mcr.microsoft.com/vscode/devcontainers/base:ubuntu

ENV DEBIAN_FRONTEND=noninteractive
ENV DISPLAY=:1

RUN apt-get update && apt-get install -y \
    xfce4 \
    xfce4-goodies \
    dbus-x11 \
    x11-xserver-utils \
    x11vnc \
    xvfb \
    novnc \
    websockify \
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

RUN mkdir -p /home/vscode/.vnc \
    /var/log/supervisor \
    /var/run/supervisor

COPY supervisord.conf /etc/supervisor/conf.d/cloudpc.conf
COPY start-desktop.sh /usr/local/bin/start-desktop.sh

RUN chmod +x /usr/local/bin/start-desktop.sh

RUN echo "vscode ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/vscode \
    && chmod 0440 /etc/sudoers.d/vscode

EXPOSE 6080

CMD ["/usr/bin/supervisord", "-n"]
