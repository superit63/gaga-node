FROM ubuntu:latest

LABEL author="XternA"
LABEL description="Unofficial docker image of GaGaNode."

RUN apt update; apt install -y sudo curl tar ca-certificates

RUN useradd -ms /bin/bash ubuntu; usermod -aG sudo ubuntu
RUN echo 'ubuntu ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN rm -rf /sbin/initctl && ln -s /sbin/initctl.distrib /sbin/initctl

# Set as default user
USER ubuntu

WORKDIR /app
COPY . .

RUN sudo chmod 777 ./run.sh
CMD ./run.sh; sleep infinity
