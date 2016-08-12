<a href="http://www.ffuenf.de" title="ffuenf - code • design • e-commerce"><img src="https://github.com/ffuenf/Ffuenf_Common/blob/master/skin/adminhtml/default/default/ffuenf/ffuenf.png" alt="ffuenf - code • design • e-commerce" /></a>

docker-shopware
===============
[![GitHub tag](https://img.shields.io/github/tag/ffuenf/docker-shopware.svg)][tag]
[![PayPal Donate](https://img.shields.io/badge/paypal-donate-blue.svg)][paypal_donate]
[![Build Status](https://img.shields.io/travis/ffuenf/docker-shopware.svg)][travis]
[![Docker Pulls](https://img.shields.io/docker/pulls/ffuenf/shopware.svg)][pulls]
[![Docker Stars](https://img.shields.io/docker/stars/ffuenf/shopware.svg)][stars]
[![Docker Layers](https://badge.imagelayers.io/ffuenf/shopware.svg)][layers]
[tag]: https://github.com/ffuenf/docker-shopware/tags
[travis]: https://travis-ci.org/ffuenf/docker-shopware
[pulls]: https://hub.docker.com/r/ffuenf/shopware/
[stars]: https://hub.docker.com/r/ffuenf/shopware/
[layers]: https://imagelayers.io/?images=ffuenf/shopware:latest
[paypal_donate]: https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=J2PQS2WLT2Y8W&item_name=docker-shopware&item_number=docker-shopware&currency_code=EUR

A docker infrastructure providing all tools required for developing shopware projects locally.

Base Image
----------

[ubuntu:xenial](https://hub.docker.com/_/ubuntu/)

Tools
-----

Tool            | Description 
:-------------- | :------------
ant             | required to configure and build shopware
php7            | required to run shopware
ionCube Loader  | required to run encrypted shopware extensions
composer        | not directly required by Shopware, as the build will also install a local composer for Shopware, but you can also use it to install Shopware via https://packagist.org/packages/shopware/shopware
curl, git, wget | necessary to execute tasks defined in Shopware's build.xml and for composer to install dependencies
openjdk-8-jdk   | required by Ant
mysql-client    | required by Shopware's build.xml to connect to the SQL database server located in another docker container
xdebug          | used for debugging PHP
phpmyadmin      | access to mysql database

Exposed Ports
-------------

* 80
* 3306

Environment Variables
---------------------

See [.env](.env) for an example.
```
    SHOPWARE_VERSION=5.2.4_b1a52d04c9c8cd60205c181eb7d51aa5a516bff0
    
    MYSQL_HOST=db:3306
    MYSQL_PORT=3306
    MYSQL_ROOT_PASSWORD=root
    MYSQL_DATABASE=shopware
    MYSQL_USER=shopware
    MYSQL_PASSWORD=yourpassword
    
    PHPMYADMIN_PW=yourpassword
```
You may overwrite these settings in your project-specific .env.

Docker Compose
--------------

See [docker-compose.yml](docker-compose.yml) for an example implementation.

Project Setup
--------------

You may start a fresh shopware project by including [docker-compose.yml](docker-compose.yml) and your customized [.env](.env).
Also create the folder-structure `var/www/html` in which shopware will be installed initially.

Development
-----------
1. Fork the repository from GitHub.
2. Clone your fork to your local machine:

        $ git clone git@github.com:USER/docker-shopware.git

3. Create a git branch

        $ git checkout -b my_bug_fix

5. Make your changes/patches/fixes, committing appropriately
7. Push your changes to GitHub
8. Open a Pull Request

License and Author
------------------

- Author:: Achim Rosenhagen (<a.rosenhagen@ffuenf.de>)
- Copyright:: 2016, ffuenf

The MIT License (MIT)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.