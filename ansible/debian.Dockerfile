FROM python:3.8-buster

# Kerberos auth not currently working
# COPY krb5.conf /etc/krb5.conf

RUN \
  export DEBIAN_FRONTEND=noninteractive && apt-get update && apt-get install -y build-essential \
  libxml2-dev \
  libxslt-dev \
  openssh-client \
  python3-jinja2 \
  python3-httplib2 \
  sshpass \
  krb5-user \
  musl

RUN \
  pip install --upgrade pip \
  ansible \
  pyvmomi \
  setuptools \
  pywinrm \
  pywinrm[kerberos] \
  kerberos \
  jinja2 \
  netaddr \
  pbr \
  hvac \
  jmespath \
  ruamel.yaml \
  google-auth \
  requests \
  openshift \
  paramiko

RUN \
  pip install --upgrade git+https://github.com/vmware/vsphere-automation-sdk-python.git

RUN mkdir /etc/ansible/ /ansible
RUN echo "[local]" >> /etc/ansible/hosts && \
    echo "localhost" >> /etc/ansible/hosts

RUN mkdir -p /ansible/playbooks
WORKDIR /ansible/playbooks

ENV ANSIBLE_GATHERING smart
ENV ANSIBLE_HOST_KEY_CHECKING false
ENV ANSIBLE_RETRY_FILES_ENABLED false
ENV ANSIBLE_ROLES_PATH /ansible/playbooks/roles
ENV ANSIBLE_SSH_PIPELINING True
ENV PATH /ansible/bin:$PATH
ENV PYTHONPATH /ansible/lib

ENTRYPOINT ["ansible-playbook"]