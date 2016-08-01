# Docker - Mozilla Sync Server

This is based on [spiroids image](https://github.com/spiroid/docker-mozilla-syncserver)!
[Mozilla Sync server](https://github.com/mozilla-services/syncserver) image for Docker, full [documentation](https://docs.services.mozilla.com/howtos/run-sync-1.5.html).
For use with [Docker](http://docker.io)

## Instructions

### With docker directly
For an easy test-startup you just have to:
```
  $ docker run -d --name syncserver birgerk/mozilla-syncserver
```

Now you have locally a syncserver running.


### With docker-compose
Same easy startup goes with docker-compose.
```
  $ docker-compose up
```

### Configuring docker-container
It's possible to configure the docker-container by setting the following environment-variables at container-startup:
* `DB_URI`, configures which database shall be used. Default is `"sqlite:////data/syncserver.db"`, which is good for tests and small environments. But for bigger environments you should consider using an external sql-db. If you want to use a mysql-db, you should set this to `"pymysql://username:password@db.example.com/sync"`. THIS IMAGE DOES NOT PROVIDE A SQLITE-FILE. If you want to use it with sqlite, you have to mount this as a volume into the container.
* `IP`, IP-Address on which the container will listen. Default is `'0.0.0.0'`, which should be good enough for most environments. Because it's a docker-container, you can also set the listening ip on host-side by setting port-forwarding on container-startup.
* `URL`, full qualified URL under which your firefox will reach this syncserver. Default is `'http://localhost:5000'`, which should work for temporary local tests.
* `SECRET`, a random string which will be used for creating "cryptographically-signed authentication tokens", for more information see [documentation](https://docs.services.mozilla.com/howtos/run-sync-1.5.html#further-configuration). Default is `''`. For longterm installations you should really set this to something safe!

If you want to use your own `settings.ini`, you can mount the file as a docker-volume to the path `/usr/local/share/config/syncserver.ini`.


## License

See [LICENSE](LICENSE) file.
