FROM docker:dind
LABEL maintainer="Matthew DePorter"

# Install dependencies (python3 + pip)
RUN apk add python3 py3-pip gcc

# Upgrade pip
RUN pip3 install -U pip
RUN pip3 install -U setuptools

# Install System Ansible
RUN apk add ansible

# Install Molecule
RUN pip3 install "molecule[docker,lint]"
