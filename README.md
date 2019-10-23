Mantis Bug Tracker Docker (MantisBT)
=============================

<p align="center">
  <a href="https://hub.docker.com/r/j4ym0/mantisbt">
    <img src="https://images.microbadger.com/badges/image/j4ym0/mantisbt.svg">
  </a>
  <a href="https://github.com/j4ym0/mantisbt-docker/releases">
    <img alt="latest version" src="https://img.shields.io/github/v/tag/j4ym0/mantisbt-docker.svg" />
  </a>
  <a href="https://hub.docker.com/r/j4ym0/mantisbt">
    <img alt="Pulls from DockerHub" src="https://img.shields.io/docker/pulls/j4ym0/mantisbt.svg?style=flat-square" />
  </a>
</p>

Screenshots
-----------

![Build Status](https://github.com/mantisbt/mantisbt/raw/master/doc/modern_view_issues.png)

![Build Status](https://github.com/mantisbt/mantisbt/raw/master/doc/modern_my_view.png)

![Build Status](https://github.com/mantisbt/mantisbt/raw/master/doc/modern_view_issue.png)

Documentation
-------------

For complete documentation, please read the administration guide from mantisbt(https://github.com/mantisbt/mantisbt/doc).  The guide is available in text, PDF, and HTML formats.



Running
-------

Run in the background 

`docker run -d -p 60001:80 --name mantisbt j4ym0/mantisbt`

Runing in the forground

`docker run -it -p 60001:80 --name mantisbt j4ym0/mantisbt`

It is recomended to us a external config_inc.php

`docker run -d -v /my/local/config_inc.php:/config/config_inc.php -p 60001:80 --name mantisbt j4ym0/mantisbt`

Use the -p arg for controling the port on the docker host, the container port is always 80 

`-p HOST_PORT:80`

To get the container to restart at boot or if it should crash add `--restart unless-stopped`

`docker run -d --restart unless-stopped -v /my/local/config_inc.php:/config/config_inc.php -p 60001:80 --name mantisbt j4ym0/mantisbt`

Access the site http://127.0.0.1:60001 if there is no config_inc.php or it is the first time you are running the container. You will go though the initial setup, you will need a SQL database server to connect to. It is not included in the container.
After instalation you will need to run `docker exec mantisbt /cleanup.sh` to cleanup the instalation folders.


Proxy Forwarding to Docker
--------------------------

Create a mantis.my-site.com.conf in /etc/apache2/sites-available

```
<VirtualHost *:80>
  ServerAdmin admin@localhost
  ServerName mantis.my-site.com
  ServerAlias mantis.my-site.com
  ProxyPreserveHost On
  ProxyRequests Off 
  ProxyPass / http://127.0.0.1:60001/
  ProxyPassReverse / http://127.0.0.1:60001/
  
  ErrorLog ${APACHE_LOG_DIR}/error.log
  CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
```

Enable the site with 

`a2ensite mantis.my-site.com`



Credits
-------

http://www.mantisbt.org/
