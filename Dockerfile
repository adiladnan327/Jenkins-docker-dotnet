# Use an official Jenkins base image
FROM jenkins/jenkins:lts

# Set the user to root to install packages
USER root

# Update the package lists and install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    gnupg \
    lsb-release \
    ca-certificates \
    apt-transport-https \
    software-properties-common \
    unzip \
    sudo \
    apt-transport-https \
    && rm -rf /var/lib/apt/lists/*
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
RUN apt-key fingerprint 0EBFCD88
RUN add-apt-repository \
      "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) stable"
# Install Docker
RUN curl -fsSL https://get.docker.com -o get-docker.sh && \
    sh get-docker.sh && \
    usermod -aG docker jenkins

# Install .NET SDK
RUN curl -sSL https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
    curl https://packages.microsoft.com/config/ubuntu/22.04/prod.list | sudo tee /etc/apt/sources.list.d/msprod.list && \
    apt-get update && \
    apt-get install -y dotnet-sdk-6.0

# Set permissions for Jenkins to run Docker
#RUN sudo chown -R jenkins:jenkins /var/run/docker.sock
RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers
    
USER jenkins

#apt-utils
# Set the user back to jenkins
#USER jenkins

# Expose port 8080 for Jenkins
#EXPOSE 8080

# Run Jenkins
#ENTRYPOINT ["/usr/bin/java", "-jar", "/usr/share/jenkins/jenkins.war"]
#ENTRYPOINT ["/usr/bin/java", "-jar, "/usr/share/jenkins/jenkins.war"]
