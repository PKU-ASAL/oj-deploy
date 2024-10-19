# PKU-OSLAB OJ Deploy

This project contains a Docker image meant to facilitate the deployment of PKU-OSLAB OJ, powered by [SDUOJ](https://github.com/SDUOJ/OnlineJudge).

## Project directory

- build: The source code of the docker image.
- env: Environment variable file for compose yaml.
- data: Some data files for running the service.

## How to use

```bash
docker compose up -d
```

The frontend is exposed at port 30080, see `.env`.

The OJ initially contains a super administrator account and a normal administrator account.

| Username    | Password  | Role        |
| ----------- | --------- | ----------- |
| superadmin  | 123456    | super admin |
| superta     | 123456    | admin       |

## How to scale

```bash
docker compose up -d --scale user-service=2
```

## Configuration

This repository contains scripts to initialize mySQL database and nacos (see `env/mysql/initdb` and `env/nacos/nacos.env`).

Some functionality is controled by nacos such as the footer, the email template, the URL, hostname, password and port of middleware services, and so on.

If you need to change such configurations, there are two ways:

1. The nacos is inited by mysql initdb scrips in `env/mysql/initdb/02-nacos-data.sql`, which contains the SQL commands to initialize the configration for each services.
You can directly change these commands for your own purpose.

2. Expose the nacos service outside of the docker container and you can connect to it via `http://localhost:8848/nacos` (to expose nacos, see comments in `compose.yml`).
You can login and change the configration in a Web UI. Note that the default username and password are both `nacos`.

## Credits

* [nacos-docker](https://github.com/nacos-group/nacos-docker)
* [docker-compose-wait](https://github.com/ufoscout/docker-compose-wait)

