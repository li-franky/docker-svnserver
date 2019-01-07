FROM centos:7.4.1708
MAINTAINER FrankyLee li-franky@163.com
LABEL name="SVN Server with Apache - Image Base CentOS" \
    vendor="FrankyLee <li-franky@163.com>" \
    license="apache license 2.0" \
    build-date="20180910"

COPY wandisco-svn.repo /etc/yum.repos.d/wandisco-svn.repo
COPY initfile /opt/initfile

RUN chmod +x /opt/initfile/init.sh && \
    yum install net-tools httpd php -y && \
    curl https://codeload.github.com/mfreiholz/iF.SVNAdmin/tar.gz/stable-1.6.2 >> svnadmin.tar.gz && \
    tar zxvf svnadmin.tar.gz && \
    mv iF.SVNAdmin-stable-1.6.2/* /var/www/html && \
    rm -rf svnadmin.tar.gz iF.SVNAdmin-stable-1.6.2 && \
    yum --disablerepo="*" --enablerepo="WandiscoSVN" install subversion mod_dav_svn -y

RUN sed -i '349i \nLimitXMLRequestBody 0\nLimitRequestBody 0' /etc/httpd/conf/httpd.conf

COPY subversion.conf /etc/httpd/conf.d/subversion.conf
COPY initfile/init.service /etc/init.d/init.service

RUN chmod 700 /etc/init.d/init.service && \
    chkconfig --add init.service

# web管理端口
EXPOSE 80

HEALTHCHECK CMD netstat -ln | grep 80 || exit 1
VOLUME [ "/var/www/html/data" ]
WORKDIR /var/www/html/data

CMD ["/usr/sbin/init"]
