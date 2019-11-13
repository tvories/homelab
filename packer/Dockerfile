FROM alpine

RUN mkdir /packer /data
# Download latest packer version and unzip
ADD https://releases.hashicorp.com/packer/1.4.4/packer_1.4.4_linux_amd64.zip /packer/packer.zip
RUN apk add unzip
RUN unzip -q /packer/packer.zip -d /usr/local/bin
RUN chmod +x /usr/local/bin/packer

# download, extract, delete tgz, and allow plugin to execute
ADD https://github.com/rgl/packer-provisioner-windows-update/releases/download/v0.7.1/packer-provisioner-windows-update-linux.tgz /packer/packer-provisioner-windows-update-linux.tgz
RUN tar -xzf /packer/packer-provisioner-windows-update-linux.tgz -C /usr/local/bin
RUN rm -rf /packer
RUN chmod +x /usr/local/bin/packer-provisioner-windows-update

# download, rename, and allow plugin to execute
ADD https://github.com/jetbrains-infra/packer-builder-vsphere/releases/download/v2.3/packer-builder-vsphere-iso.linux /usr/local/bin/packer-builder-vsphere-iso
RUN chmod +x /usr/local/bin/packer-builder-vsphere-iso

# ENTRYPOINT [ "/usr/local/bin/packer" ]
WORKDIR /data