## Run Service

```bash
podman compose up -d
```

As compose will be executed by a non sudo user, when `ssh` logout, compose will stop so enable lingering for user will keep the session

```bash
sudo loginctl enable-linger username
```

