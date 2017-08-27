FROM oott123/novnc:latest

RUN apt-get update && \
    apt-get install -y \
        software-properties-common \
        python-software-properties \
        python3-software-properties \
        cabextract unzip \
        language-pack-zh-hans ttf-wqy-zenhei ttf-wqy-microhei && \
    locale-gen zh_CN.UTF-8 && \
    add-apt-repository -y ppa:wine/wine-builds && \
    dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y --install-recommends winehq-devel && \
    wget -O /usr/local/bin/winetricks https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks && \
    chmod 755 /usr/local/bin/winetricks && \
    apt-get clean

RUN sudo -Hu user /usr/local/bin/winetricks -q win7 && \
    sudo -Hu user /usr/local/bin/winetricks -q winhttp && \
    sudo -Hu user /usr/local/bin/winetricks -q msscript && \
    sudo -Hu user /usr/local/bin/winetricks -q fakechinese && \
    sudo -Hu user /usr/local/bin/winetricks -q fontsmooth=rgb && \
    mkdir /home/user/coolq

ENV LANG=zh_CN.UTF-8 \
    LC_ALL=zh_CN.UTF-8 \
    COOLQ_URL=http://dlsec.cqp.me/cqa-tuling

COPY vncmain.sh /app/vncmain.sh
COPY cq /usr/local/bin/cq
COPY cont-init.d /etc/cont-init.d/

VOLUME ["/home/user/coolq"]