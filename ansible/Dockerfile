FROM jfloff/alpine-python:latest

# Kerberos auth not currently working
# COPY krb5.conf /etc/krb5.conf

RUN \
  apk add build-base \
  openssl-dev \
  libxml2-dev \
  libxslt-dev \
  openssh-client \
  py3-jinja2 \
  py3-httplib2 \
  sshpass \
  krb5 \
  krb5-dev \
  krb5-libs \
  libcom_err \
  musl

RUN \
  pip install --upgrade pip \
  ansible \
  pyvmomi \
  setuptools \
  pywinrm \
  pywinrm[kerberos] \
  kerberos

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