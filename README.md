# ansible-molecule-dind

Docker container capable of running Ansible + Ansible-Molecule. This container uses the Docker-in-Docker container as a base so that Ansible-Molecule can create containers inside this container.

Here's the article that this container is sourced from: https://devopscube.com/run-docker-in-docker/

The container can be found [here.](https://hub.docker.com/repository/docker/spikebyte/ansible-molecule-dind/general)

## Usage

How to use this container:

```
# Pull the latest version of this container
docker pull spikebyte/ansible-molecule-dind:latest

# Change to your Ansible work directory
cd <path-to-ansible-code>

# Start up the dind container in the background (daemonized)
docker run --privileged -d --name ansible-dind -v $(pwd):/work spikebyte/ansible-molecule-dind

# "Login" to your container
docker exec -it ansible-dind sh

# Change to working directory and execute code
cd /work/roles/<role-name>

# Run a molecule converge
molecule converge -- -vvv
```

## Build

```
docker build -f Dockerfile -t spikebyte/ansible-molecule-dind:latest .

docker login --username <docker-username>
# Paste Docker Hub Token

docker push spikebyte/ansible-molecule-dind:latest
```
