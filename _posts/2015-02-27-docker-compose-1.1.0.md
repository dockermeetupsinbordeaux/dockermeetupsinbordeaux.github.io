---
layout: post
title: "Docker releases Compose 1.1.0"
date: 2015-02-27
categories: docker-compose release
author: tristan
---

[Docker-compose][dc-gh] is a Python tool that allows you to describe your multi-containers application in one single YAML file. Previously known as Fig, Docker compose is now part of the Docker eco-system since acquisition of Orchard Laboratories last summer.

# Easy Installation
As *docker-compose* requires specific versions of [its dependencies][dc-deps], it is recommended to use a dedicated virtualenv environment to prevent messing up your packages installation setup. You can use the script below that takes care of creating the virtualenv sandbox environment dedicated to docker-compose.

    curl -sL http://git.io/xe2x | sh -

You can define environment variables to specify installation location:

* **PREFIX**: Root directory where the virtualenv is installed [/usr/local/stow]
* **NAME**: virtualenv name [docker-compose]
* **VERSION**: wished docker-compose version [1.1.0]       

For instance:

    curl -sL http://git.io/xeR4 | PREFIX="$HOME/tools" sh -

> shell script is available [here][dc-gist].

# Getting started

Documentation is now officially hosted on Docker [documentation website][dc-doc].
You can follow their sample waiting for what follows on this website!

[dc-gh]:   https://github.com/docker/compose
[dc-doc]:  http://docs.docker.com/compose/
[dc-deps]: https://github.com/docker/compose/blob/1.1.0/requirements.txt
[dc-gist]: https://gist.github.com/a34d483584327b73ff1c.git
