nginx-lua
=========

![Docker stars](https://img.shields.io/docker/stars/danday74/nginx-lua.png "Docker stars")
&nbsp;
![Docker pulls](https://img.shields.io/docker/pulls/danday74/nginx-lua.png "Docker pulls")

[![Docker repo](https://github.com/danday74/docker-nginx-lua/blob/master/images/docker.png?raw=true "Docker repo")](https://registry.hub.docker.com/u/danday74/nginx-lua)
&nbsp;
[![Github repo](https://github.com/danday74/docker-nginx-lua/blob/master/images/github.png?raw=true "Github repo")](https://github.com/danday74/docker-nginx-lua)

Dockerised Nginx, with Lua module, built from source

The docker image is based on the manual compilation instructions at ...

[http://wiki.nginx.org/HttpLuaModule#Installation](http://wiki.nginx.org/HttpLuaModule#Installation)

Useful for those who want Nginx with Lua but don't want to use OpenResty

upd: Dockerfile is changed to contain the last version of lua module

Usage
-----

1. Run ./run_dcoker_machine to create an aws instance and launch jenkins master in dind container on it
    ```

2. If successfull you will be prompted with Jenkisn web console ip, master password and GitHub webhook endpoint

    If you don't have an **nginx.conf** file then use [the conf file](https://raw.githubusercontent.com/danday74/docker-nginx-lua/master/nginx.conf) provided in the github repo
    
    The conf file provided is the default generated conf file with the above location block added

3. Jenkins might be managed via webconsole to enable build on GitHub push


License
-------

[http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)

APACHE LICENSE-2.0 ... In other words, please use freely and do whatever you want with it!
