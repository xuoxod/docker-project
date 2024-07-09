FROM ubuntu
LABEL com.rmediatech.image.author="rick@rmediatech.com"

# Skip prompts
ARG DEBIAN_FRONTEND=noninteractive

# Update packages
RUN apt update && apt dist-upgrade -y 

# Install packages
RUN apt install htop bat net-tools netwox shc locate tree -y

# Run in host's network environment
RUN --network=host

# Create default user and setup env
RUN useradd -m xuaxad -c "default user"
RUN usermod -aG sudo xuaxad

ADD --chown=xuaxad:xuaxad "./.user-env/*" "/home/xuaxad/"
USER xuaxad
# CMD /bin/bash
WORKDIR /home/xuaxad

# Create a development dir structure
RUN cd /home/xuaxad && \
    mkdir -p private/projects/desktop private/projects/web \
    private/projects/golang private/projects/ssh private/projects/desktop/bash && \
    cd /home/xuaxad && mkdir bin && mkdir -p private/projects/desktop/bash/proj1

ADD --chown=xuaxad:xuaxad "./.user-scripts/*.sh" "/home/xuaxad/private/projects/desktop/bash/proj1/"

# Set entry point
ENTRYPOINT ["/bin/bash"]
