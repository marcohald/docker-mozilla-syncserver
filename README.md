# Docker - Mozilla Sync Server

This is based on [spiroids image](https://github.com/spiroid/docker-mozilla-syncserver)!
[Mozilla Sync server](https://github.com/mozilla-services/syncserver) image for Docker, full [documentation](https://docs.services.mozilla.com/howtos/run-sync-1.5.html).

## Instructions

### With docker-compose
For an easy test-startup you just have to:
```
  $ docker-compose up
```
Now you have locally a syncserver running.

### Prod-env
If you want to run a sync-server in a more productive way, please prepare a mysql-server (like shown in the docker-compose.yml).

### Configuring docker-container
It's possible to configure the docker-container by setting the following environment-variables at container-startup:
* `DB_URI`, configures which database shall be used. This image only supports mysql-db. Given like `"pymysql://username:password@db.example.com/sync"`.
* `IP`, IP-Address on which the container will listen. Default is `'0.0.0.0'`, which should be good enough for most environments. Because it's a docker-container, you can also set the listening ip on host-side by setting port-forwarding on container-startup.
* `URL`, full qualified URL under which your firefox will reach this syncserver. Default is `'http://localhost:5000'`, which should work for temporary local tests.
* `SECRET`, a random string which will be used for creating "cryptographically-signed authentication tokens", for more information see [documentation](https://docs.services.mozilla.com/howtos/run-sync-1.5.html#further-configuration). Default is `''`. For longterm installations you should really set this to something safe!

If you want to use your own `settings.ini`, you can mount the file as a docker-volume to the path `/usr/local/share/config/syncserver.ini`.


## License

See [LICENSE](LICENSE) file.
