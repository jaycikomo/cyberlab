FROM kalilinux/kali-rolling:latest

RUN apt-get update && apt-get install -y \
    kali-linux-core \
    nmap \
    sqlmap \
    nikto \
    dirb \
    hydra \
    john \
    metasploit-framework \
    burpsuite \
    wireshark \
    tcpdump \
    netcat-openbsd \
    curl \
    wget \
    ssh \
    vim \
    && apt-get clean

RUN useradd -m -s /bin/bash kali && \
    echo 'kali:kali' | chpasswd && \
    echo 'root:toor' | chpasswd

RUN mkdir -p /root/tools /home/kali/tools && \
    chown -R kali:kali /home/kali/tools

EXPOSE 22

CMD ["/bin/bash"]
