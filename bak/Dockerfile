##FROM ubuntu:14.04
##RUN apt-get update && apt-get upgrade && DEBIAN_FRONTEND=noninteractive apt-get install -y lxde-core
##WORKDIR /tmp
##CMD ["bash"]
FROM ubuntu-lxde
RUN export uid=20052 gid=20005 && \
    mkdir -p /home/jmarsden && \
    echo "jmarsden:x:${uid}:${gid}:,,,:/home/jmarsden:/bin/bash" >> /etc/passwd && \
    echo "jmarsden:x:${uid}:" >> /etc/group && \
    echo "jmarsden ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/jmarsden && \
    chmod 0440 /etc/sudoers.d/jmarsden && \
    chown ${uid}:${gid} -R /home/jmarsden
USER jmarsden
WORKDIR /tmp
COPY JetPack-L4T-2.1-linux-x64.run /tmp/JetPack.run
CMD ["bash"]
#RUN cd /tmp && ./JetPack.run
#RUN apt-get update && apt-get upgrade && apt-get install -y wget
#RUN wget -o /tmp/JetPack.run http://developer.download.nvidia.com/assets/embedded/secure/tools/files/jetpack_2.1/02/JetPack-L4T-2.1-linux-x64.run?autho=1464373337_03c615b5804ac355493985bd2ad5ed03&file=JetPack-L4T-2.1-linux-x64.run && chmod +x /tmp/JetPack.run && /tmp/JetPack.run
#RUN wget -O - http://repo.linaro.org/ubuntu/linarorepo.key| apt-key add -
#RUN echo "deb http://repo.linaro.org/ubuntu/linaro-overlay trusty main" > /etc/apt/sources.list.d/linaro.list
#RUN apt-get update && apt-get upgrade -y
#RUN apt-get install -y gcc-aarch64-linux-gnu g++-aarch64-linux-gnu
#RUN apt-get install libc-dev-bin
