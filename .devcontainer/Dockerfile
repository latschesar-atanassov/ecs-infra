FROM mcr.microsoft.com/vscode/devcontainers/base

RUN sudo apt update
RUN sudo apt-get install -y software-properties-common apt-transport-https ca-certificates curl gnupg lsb-release

# install docker cli
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
RUN echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  xenial stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
RUN sudo apt-get update
RUN sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# install kubectl
RUN sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
RUN sudo apt-get update
RUN sudo apt-get install -y kubectl

# install terraform
RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
RUN sudo apt-add-repository "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
RUN sudo apt update
RUN sudo apt install terraform

# install python3
RUN sudo apt-get install -y python3 python3-pip

# install pre-commit
RUN pip3 install pre-commit

# install awsume
RUN pip3 install awsume


# install awscli
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN sudo ./aws/install
RUN rm awscliv2.zip

# install az cli
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# install sam cli
RUN wget "https://github.com/aws/aws-sam-cli/releases/latest/download/aws-sam-cli-linux-x86_64.zip"
RUN unzip aws-sam-cli-linux-x86_64.zip -d sam-installation
RUN sudo ./sam-installation/install
RUN rm aws-sam-cli-linux-x86_64.zip

# install helm
RUN curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# install checkov
RUN pip3 install checkov