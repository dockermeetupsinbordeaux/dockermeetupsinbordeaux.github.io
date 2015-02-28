---
layout: post
title: "Minimalistic data-only container for Docker Compose"
date: 2015-03-01
categories: docker-compose data-container
author: tristan
---

I used Docker Compose lately to bootstrap our development environment at Cogniteev in a blink of an eye.

To collect data and logs written by the different containers that **composes** our application, I setup a data-only container.

But what is a data-only container?
> This is a container that references a volume. It does not even need to run. Then you can use the `--volumes-from` Docker option to mount this volume on every container that needs to access data in the volume.

Docker documentation provides examples for working with data-only containers, but they use *ubuntu* for base image. It is ~200MB of useless stuff. I have used the ~2.5MB neat [busybox][busybox] Docker image. I find it perfect for `docker run <blablabla>` operations but this is a maze of symbolic links and you don't want to mess with it by mount volumes over it.

So I started looking around on Docker Hub for a minimalist Docker image, and I found my holy grail with [tianon/true][tianon-true] that is a 125 bytes long Docker image providing `/true` written in über-efficient assembler and that's it.

So far so good, until I start using it with Docker Compose: I came across a weird issue when Docker Compose starts the data-only container:

```
Cannot start container a6da0c7e877b1075696d64802f7e159b7660e5cd395064b891ab5712c74bc266: exec: "/bin/echo": stat /bin/echo: no such file or directory
<PUT_ERROR_MESSAGE_HERE>
```

After some digging, I found [docker compose issue #919][compose-919] showing that Docker Compose assumes every container has the `/bin/echo` executable. This is just the tip of the iceberg, there are interested referenced discussions you might want to dig in.

Anyway, as a work-around, I created a new [cogniteev/true][cogniteev-true] Docker image that only provides the `/bin/echo`. As of now, it is written in C, and use `libc` so it about 1MB fat. I can't wait to find the time to write it in assembler to get rid of the static libgcc embedded in the executable :)

You will find on the source code repository a [sober tutorial][cogniteev-true-tutorial] showing how to create a data-only container, how to produce data into it, and how to retrieve them.

[busybox]: https://registry.hub.docker.com/_/busybox/
[tianon-true]: https://registry.hub.docker.com/u/tianon/true/
[cogniteev-true]: https://registry.hub.docker.com/u/cogniteev/true/
[cogniteev-true-tutorial]: [https://github.com/cogniteev/docker-echo#basic-usage-with-docker]
[compose-919]: https://github.com/docker/compose/issues/919#issuecomment-76426985]
