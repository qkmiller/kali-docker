FROM kalilinux/kali-rolling
LABEL org.opencontainers.image.authors="https://github.com/qkmiller"
ENV TERM="xterm-256color"
SHELL ["/bin/bash", "-c"]


# Build arguments. Passed using --build-arg <ARG>=<STRING>
ARG user password


# Replace http://kali.download/kali/ with a mirror of your choosing from
# http://http.kali.org/README.mirrorlist or comment/remove it to use the 
# default mirror (metalink).
RUN echo "deb http://kali.download/kali/ kali-rolling main contrib non-free" > /etc/apt/sources.list


# Update and install new packages
RUN apt -y update && \
    apt -y full-upgrade && \
    apt -y install less man openvpn sudo curl tmux vim nano iputils-ping && \
    apt -y auto-remove
    #apt -y install kali-linux-headless && \

# Replace resolvconf with openresolv (This fixes weird DNS issues)
RUN apt -y remove resolvconf && apt -y install openresolv;


# Create a new user using the build args
RUN useradd -m -s /usr/bin/bash $user && \
    echo "$user:$password" | chpasswd && \
    usermod -aG sudo $user

USER $user
WORKDIR /home/$user
