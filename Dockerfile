FROM docker:dind
LABEL maintainer="Matthew DePorter"

# Install dependencies (python3 + pip)
# RUN apk add python3 py3-pip gcc
RUN apk update && apk add --no-cache \
    build-base \
    libffi-dev \
    openssl-dev \
    python3-dev \
    py3-pip

RUN pip3 install --upgrade pip setuptools --break-system-packages

RUN pip3 install cffi --break-system-packages

# Allow installing stuff to system Python.
RUN rm -f /usr/lib/python3.11/EXTERNALLY-MANAGED

# Upgrade pip
RUN pip3 install -U pip --break-system-packages

# Install System Ansible
RUN pip3 install cffi ansible cryptography --break-system-packages

# Install Molecule
# RUN pip3 install "molecule[docker,lint]"

COPY initctl_faker .
RUN chmod +x initctl_faker && rm -fr /sbin/initctl && ln -s /initctl_faker /sbin/initctl

# Install Ansible inventory file.
RUN mkdir -p /etc/ansible
RUN echo "[local]\nlocalhost ansible_connection=local" > /etc/ansible/hosts

# Make sure systemd doesn't start agettys on tty[1-6].
RUN rm -f /lib/systemd/system/multi-user.target.wants/getty.target

VOLUME ["/sys/fs/cgroup"]
CMD ["/lib/systemd/systemd"]