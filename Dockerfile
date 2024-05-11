FROM amazon/aws-cli

RUN yum install -y unzip curl tar gzip

# Install kubectl
RUN curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.21.2/2021-07-05/bin/linux/amd64/kubectl && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/local/bin/kubectl

RUN mkdir /tmp/eksctl 

RUN curl -L "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_Linux_amd64.tar.gz" -o /tmp/eksctl.tar.gz && \
    tar xzf /tmp/eksctl.tar.gz -C /tmp && \
    mv /tmp/eksctl /usr/local/bin && \
    rm /tmp/eksctl.tar.gz

RUN eksctl version
# Install Kompose
RUN curl -L https://github.com/kubernetes/kompose/releases/download/v1.26.1/kompose-linux-amd64 -o kompose && \
    chmod +x kompose && \
    mv kompose /usr/local/bin/

# Set the entrypoint to bash
ENTRYPOINT ["/bin/bash"]