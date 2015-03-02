---
layout: post
title: "Minimalistic data-only container for Docker Compose"
date: 2015-03-01
categories: docker-compose data-container
author: tristan
---

Feedback of using data-only data container with Compose.

I used Docker Compose lately to bootstrap our development environment at [Cogniteev][cogniteev] in a blink of an eye.

To collect data and logs written by the different containers that *composes* our application, I setup a data-only container.

Everybody tells on the net what he things a data-only container is. Let me do the same :)
> This is a container that references a volume. It does not even need to run. Then you can use the `--volumes-from` Docker option to mount this volume on every container that needs to access data in the volume.

Docker documentation provides examples for working with data-only containers, but they use *ubuntu* for base image. It is ~200MB of useless stuff. I have used the ~2.5MB neat [busybox][busybox] Docker image. I find it perfect for `docker run <blablabla>` operations but this is a maze of symbolic links and you will lose your last shreds of sanity if you mount volumes on top of it.

So I started looking around on Docker Hub for a minimalist Docker image, and I found my holy grail with [tianon/true][tianon-true] that is a 125 bytes long Docker image providing `/true` written in über-efficient assembler and that's it.

So far so good, until I start using it with Docker Compose: I came across a weird issue when Docker Compose starts a container based on this image:

> Cannot start container a6da0c7e877b1075696d64802f7e159b7660e5cd395064b891ab5712c74bc266: exec: "/bin/echo": stat /bin/echo: no such file or directory

After some digging, I found [docker compose issue #919][compose-919] showing that Docker Compose assumes every container has the `/bin/echo` executable. This is just the tip of the iceberg, there are interested referenced discussions you might want to dig in.


Anyway, as a work-around, I created a new [cogniteev/true][cogniteev-true] Docker image that only provides the `/bin/echo`. As of now, it is written in C, and use `libc` so it about 1MB fat. I can't wait to find the time to write it in assembler to get rid of the static libgcc embedded in the executable :)

here is how you can use it:

1. Create a data container named *data_container*:

    sudo docker run -v /data --name data_container cogniteev/echo 

2. Create a new container that:
    * mounts volume `/data` of *data_container* container
    * creates a file named `/data/bar`
    * is deleted once the container stops

    sudo echo foo | docker run --volumes-from data_container -i --rm  busybox tee /data/bar

3. Create a new container that:
    * mounts volume `/data` of *data_container* container
    * reads content of file `/data/bar`
    * is deleted once the container stops

    sudo docker run --volumes-from data_container --rm busybox cat /data/bar


[busybox]: https://registry.hub.docker.com/_/busybox/
[cogniteev]: http://cogniteev.com
[tianon-true]: https://registry.hub.docker.com/u/tianon/true/
[cogniteev-true]: https://registry.hub.docker.com/u/cogniteev/true/
[cogniteev-true-tutorial]: [https://github.com/cogniteev/docker-echo#basic-usage-with-docker]
[compose-919]: https://github.com/docker/compose/issues/919#issuecomment-76426985]
