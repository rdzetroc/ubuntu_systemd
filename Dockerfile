FROM ubuntu:latest
ENV container docker
RUN apt-get update -y && apt-get clean all
RUN apt-get install systemd -y && apt-get clean all 
RUN ["/bin/bash",(cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; echo $i; done) && \ 
rm -f /lib/systemd/system/multi-user.target.wants/* && \
rm -f /etc/systemd/system/*.wants/* && \
rm -f /lib/systemd/system/local-fs.target.wants/* && \
rm -f /lib/systemd/system/sockets.target.wants/*udev* && \ 
rm -f /lib/systemd/system/sockets.target.wants/*initctl* && \ 
rm -f /lib/systemd/system/basic.target.wants/*]
VOLUME [ "/sys/fs/cgroup" ]
CMD ["/bin/systemd", "--system", "--unit=basic.target"]