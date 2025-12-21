# Inmich Image Server

[Inmich](https://immich.app/) is an Open Source solution for content sharing as images and videos. On this repository, a [compose file](./docker-compose.yml) if provided to self host this service.

It is recommended to use [podman](https://podman.io/) with a non-sudo user to run the server in order to mitigate privilege escalation wich can leverage on an attacker gaining access to host.

## Run Service

```bash
podman compose up -d
```

As compose will be executed by a non sudo user, when `ssh` logout, compose will stop so enable lingering for user will keep the session

```bash
sudo loginctl enable-linger username
```

