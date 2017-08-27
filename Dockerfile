FROM oott123/novnc:latest

RUN apt-get update && \
    apt-get install -y \
        software-properties-common apt-transport-https \
        cabextract unzip python-numpy \
        language-pack-zh-hans ttf-wqy-microhei && \
    # 安装 wine
    wget -nc https://dl.winehq.org/wine-builds/Release.key -O /tmp/wine.key && \
    apt-key add /tmp/wine.key && rm -f /tmp/wine.key && \
    apt-add-repository -y https://dl.winehq.org/wine-builds/ubuntu && \
    dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y --install-recommends winehq-devel && \
    wget -O /usr/local/bin/winetricks https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks && \
    chmod 755 /usr/local/bin/winetricks && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists

COPY winhttp_2ksp4.verb /tmp/winhttp_2ksp4.verb

RUN sudo -Hu user WINEARCH=win32 /usr/bin/wine wineboot && \
    sudo -Hu user /usr/local/bin/winetricks -q win7 && \
    sudo -Hu user /usr/local/bin/winetricks -q /tmp/winhttp_2ksp4.verb && \
    sudo -Hu user /usr/local/bin/winetricks -q msscript && \
    sudo -Hu user /usr/local/bin/winetricks -q fakechinese && \
    sudo -Hu user /usr/local/bin/winetricks -q fontsmooth=rgb && \
    mkdir /home/user/coolq && \
    chsh -s /bin/bash user && \
    rm -rf /home/user/.cache/winetricks

ENV LANG=zh_CN.UTF-8 \
    LC_ALL=zh_CN.UTF-8 \
    COOLQ_URL=http://dlsec.cqp.me/cqa-tuling

COPY vncmain.sh /app/vncmain.sh
COPY cq /usr/local/bin/cq
COPY cont-init.d /etc/cont-init.d/

VOLUME ["/home/user/coolq"]
