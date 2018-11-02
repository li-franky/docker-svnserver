# docker-svnserver
Subversion with Apache - Image Base CentOS 7.4.1708 带WEB管理工具的SVN服务器。

启动方式：
docker run -d --name svnserver \
--volume /opt/svn_repo:/var/www/html/data \
--publish 80:80 \
frankylee/websvn:0.1
说明：
--name svnserver：容器名称
--volume /opt/svn_repo:/var/www/html/data：/opt/svn_repo是宿主机目录，用于持久化svn数据
--publish 80:80：映射到宿主机的端口号
frankylee/websvn:0.1：docker镜像的名称和版本号。

访问地址 ：http://<宿主机IP>:<映射到宿主机的端口号>
