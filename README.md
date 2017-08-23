# Django, uWSGI in a container, using Supervisord

## 包含Django和uWSGI 输出uwsgi协议端口 外部nginx转发

该镜像相比于`no-nginx`镜像采用了动态配置文件和动态启动脚本，依次挂载在

* `/home/docker/code/custom/` 这个是动态启动脚本

* `/home/docker/code/config/` 这个是动态`Supervisord`配置文件

可以采用动态`Supervisord`配置文件加载启动脚本，实现自定义`daemon`