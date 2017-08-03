FROM frekele/gradle:2-jdk8
RUN apt-get update -y && \
    apt-get install -y git-core && apt-get install -qqy \
    apt-transport-https \
    ca-certificates \
    curl \
    lxc \
    iptables

ADD https://storage.googleapis.com/kubernetes-release/release/v1.3.6/bin/linux/amd64/kubectl /usr/local/bin/kubectl
ADD entrypoint.sh /entrypoint.sh

RUN chmod +x /usr/local/bin/kubectl && \
    chmod +x /entrypoint.sh && \
    kubectl version --client

# Install Docker from Docker Inc. repositories.
RUN curl -sSL https://get.docker.com/ | sh

# Install the magic wrapper.
ADD ./wrapdocker /usr/local/bin/wrapdocker
RUN chmod +x /usr/local/bin/wrapdocker

# Define additional metadata for our image.
VOLUME /var/lib/docker
ENTRYPOINT ["wrapdocker"]

