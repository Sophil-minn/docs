#直接在容器内安装vim工具，直接编辑
###  首先，更换apt-get源，然后再docker容器内安装vim
```
mv /etc/apt/sources.list /etc/apt/sources.list.bak
echo "deb http://mirrors.163.com/debian/ jessie main non-free contrib" >> /etc/apt/sources.list
echo "deb http://mirrors.163.com/debian/ jessie-proposed-updates main non-free contrib" >>/etc/apt/sources.list
echo "deb-src http://mirrors.163.com/debian/ jessie main non-free contrib" >>/etc/apt/sources.list
echo "deb-src http://mirrors.163.com/debian/ jessie-proposed-updates main non-free contrib" >>/etc/apt/sources.list
apt-get update
apt-get install -y vim
```



docker 只要这样进入容器即可输入中文: docker exec -it b18f56aa1e15 env LANG=C.UTF-8 /bin/bash