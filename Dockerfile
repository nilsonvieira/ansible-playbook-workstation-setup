FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    ansible \
    git \
    openssh-client \
    python3 \
    python3-pip \
    python3-six \
    sshpass \
    && rm -rf /var/lib/apt/lists/*

RUN pip3 install ansible six

WORKDIR /workspace

COPY requirements.yml .
RUN ansible-galaxy install -r requirements.yml

ENTRYPOINT ["ansible-playbook"]
CMD ["--version"]