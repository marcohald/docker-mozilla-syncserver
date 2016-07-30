# Docker - Mozilla Sync Server

This is based on https://github.com/spiroid/docker-mozilla-syncserver!
[Mozilla Sync server](https://github.com/mozilla-services/syncserver) image for Docker.
For use with [Docker](http://docker.io)

All suggestions and contributions are very welcome.
There is a room for improvements, so please feel free to open issues and pull requests to help improve these images.

## Disclamer

This image configures a very light sync server that stores data in a sqlite db and uses the built-in server. As stated on the [server's documentation page](https://docs.services.mozilla.com/howtos/run-sync-1.5.html):
>  it does not really support a lot of load

You will almost certainly want to configure another database and / or serve the content with gunicorn. I plan to add instructions and configuration files to achieve that with this docker image.

## Getting stared

### Requirements
 * [Git](http://git-scm.com/)
 * [Docker](http://docker.io)

### Get the source code
```
  $ git clone git@github.com:spiroid/docker-mozilla-syncserver.git
  $ cd docker-mozilla-syncserver
```

## Intro

This builds two docker elements :

* One image with the latest version of the sync server in standalone mode
* A [data volume container](https://docs.docker.com/userguide/dockervolumes/) to persist data between different containers (sqlite db)


## Instructions

### With docker directly

 * Build the syncserver image

Replace ```<your pseudo>``` by a prefix you want to appear in your local docker image registry.

```
  $ docker build -t <your pseudo>/syncserver ./syncserver
```

 * Run

```
  $ docker run -v /data --name syncserverdata busybox
  $ docker run -d -p 5000:5000 --volumes-from syncserverdata --name syncserver <your pseudo>/syncserver
```


### With [fig](http://www.fig.sh/)

Follow the instructions as described on the [fig documentation page](http://www.fig.sh/install.html)  
My favorite install method: `$ sudo pip install -U fig`.

Then, getting the container to build and run becomes be as easy as:

```
  $ fig up
```

### Configuring docker-container
It's possible to configure the docker-container by setting the following environment-variables at container-startup:
* `DB_URI`, configures which database shall be used. Default is `"sqlite:////data/syncserver.db"`, which is good for tests and small environments. But for bigger environments you should consider using an external sql-db. If you want to use a mysql-db, you should set this to `"pymysql://username:password@db.example.com/sync"`.
* `IP`, IP-Address on which the container will listen. Default is `'0.0.0.0'`, which should be good enough for most environments. Because it's a docker-container, you can also set the listening ip on host-side by setting port-forwarding on container-startup.
* `URL`, full qualified URL under which your firefox will reach this syncserver. Default is `'http://localhost:5000'`, which should work for temporary local tests.
* `SECRET`, a random string which will be used for creating "cryptographically-signed authentication tokens", for more information see [documentation](https://docs.services.mozilla.com/howtos/run-sync-1.5.html#further-configuration). Default is `''`. For longterm installations you should really set this to something safe!


## License

See [LICENSE](LICENSE) file.
