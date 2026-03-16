FROM jenkins/jenkins:lts

USER root

RUN apt-get update && apt-get install -y \
    unzip \
    curl \
    docker.io \
    git 

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install && \
    rm -rf aws awscliv2.zip

RUN usermod -aG docker jenkins

# EXPOSE 8080
# EXPOSE 50000

USER jenkins
