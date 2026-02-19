FROM ubuntu:24.04

ARG TARGETARCH
ENV NOVNC_PACKAGE=https://github.com/novnc/noVNC/archive/refs/tags/v1.3.0.tar.gz
ENV VNC_SERVER_PASSWD=password

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
ENV LANGUAGE=zh_CN:zh

# Variables needed for non interactive tzdata installation.
ENV TZ=Asia/Shanghai
ENV DEBIAN_FRONTEND="noninteractive"

RUN apt-get -qqy update && \
  apt-get -qqy install \
    supervisor \
    wget \
    x11vnc \
    xvfb \
    websockify \
    i3status \
    i3-wm \
    desktop-file-utils \
    libappindicator3-1 \
    libasound2t64 \
    libnss3 \
    libgtk-3-0 \
    libfontconfig \
    libfreetype6 \
    libgbm-dev \
    libnotify4 \
    libsecret-1-0 \
    libcap2-bin \
    xfonts-cyrillic \
    xfonts-scalable \
    fonts-liberation \
    fonts-ipafont-gothic \
    fonts-wqy-zenhei \
    xdg-utils && \
  rm -rf /var/lib/apt/lists/* && \
  apt-get -qyy clean

RUN mkdir /root/.vnc && \
  touch /root/.vnc/passwd

RUN if [ "$TARGETARCH" = "arm64" ]; then \
    BAIDUNETDISK_PACKAGE="https://issuepcdn.baidupcs.com/issue/netdisk/LinuxGuanjia/4.17.7/baidunetdisk_4.17.7_arm64.deb"; \
  else \
    BAIDUNETDISK_PACKAGE="https://issuepcdn.baidupcs.com/issue/netdisk/LinuxGuanjia/4.17.7/baidunetdisk_4.17.7_amd64.deb"; \
  fi && \
  wget ${BAIDUNETDISK_PACKAGE} -O baidunetdisk.deb && \
  dpkg -i baidunetdisk.deb && \
  rm baidunetdisk.deb -f

# Download and extract noVNC, then remove the version number in directory name.
RUN wget ${NOVNC_PACKAGE} -O novnc.tar.gz && \
  mkdir -p /root/novnc && \
  tar -xzf novnc.tar.gz -C /root/novnc && \
  rm novnc.tar.gz websockify.tar.gz -f && \
  mv /root/novnc/noVNC-* /root/novnc/noVNC

COPY supervisord.conf /root/supervisord.conf
COPY i3_config /root/.config/i3/config
COPY index.html /root/novnc/noVNC/index.html

EXPOSE 5900
EXPOSE 6080

CMD ["sh", "-c", "echo \"VNC (vnc://localhost:5900) password is $VNC_SERVER_PASSWD\" && /usr/bin/x11vnc -storepasswd $VNC_SERVER_PASSWD ~/.vnc/passwd && /usr/bin/supervisord -c /root/supervisord.conf && /usr/bin/tail -f /dev/null"]
