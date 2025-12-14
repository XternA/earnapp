# EarnApp Docker 💵🐳

>**Note:** This image is unofficial, not affiliated with EarnApp, and comes with no warranty.

This repository provides Docker images for running EarnApp in lightweight, isolated containers. Two variants are available:

| Image Base         | Channel            | Registry               | Tag    | Size   |
|:-------------------|:-------------------|:-----------------------|:------:|:------:|
| debian:trixie-slim | Main / Stable      | ghcr.io/xterna/earnapp | latest | 74MB   |
| alpine:latest      | Secondary / Stable | ghcr.io/xterna/earnapp | alpine | 31MB   |

### Features
- Ready-to-run EarnApp containers.
- Both images are designed to be lightweight and small.
- Debian image for maximum compatibility.
- Alpine image for minimal footprint.
- Multi-architecture support: `amd64`, `arm64`, `arm/v7 (Debian|Alpine)`, `arm/v6 (Debian)`
- Auto UUID generation or provide existing or externally.

Spin up in seconds and start earning, no setup hassles, fast and clean output.

### Output
```sh
> docker logs earnapp
```
```
  _____    _    ____  _   _    _    ____  ____
 | ____|  / \  |  _ \| \ | |  / \  |  _ \|  _ \
 |  _|   / _ \ | |_) |  \| | / _ \ | |_) | |_) |
 | |___ / ___ \|  _ <| |\  |/ ___ \|  __/|  __/
 |_____/_/   \_\_| \_\_| \_/_/   \_\_|   |_|

v1.570.397

✔ UUID:   sdk-node-8f2d5c3a1b7e46d029f1a8c4e5b37d6f
✔ Status: enabled

⚠ You must register it for earnings to be added to your account.
⚠ Open the following URL in the browser:
  https://earnapp.com/r/sdk-node-8f2d5c3a1b7e46d029f1a8c4e5b37d6f
```

### Resource Usage
Ultra-light usage, perfect for scaling.
```
CONTAINER ID   NAME        CPU %     MEM USAGE / LIMIT   MEM %     NET I/O           BLOCK I/O   PIDS
9a662f58141f   earnapp     0.00%     1.066MiB / 350MiB   0.30%     17.4kB / 126B     0B / 0B     2
35d450382eb8   earnapp-1   0.00%     984KiB / 350MiB     0.27%     51.1MB / 21.5MB   0B / 0B     2
1c438dd3946c   earnapp-2   0.00%     976KiB / 350MiB     0.27%     45.7MB / 11MB     0B / 0B     2
91a27d7b4dee   earnapp-3   0.00%     472KiB / 350MiB     0.13%     1.8GB / 1.13GB    4.1kB / 0B  2
f90fe8014675   earnapp-4   0.00%     468KiB / 350MiB     0.13%     1.58GB / 896MB    0B / 0B     2
```

## Usage 🐳

There are two ways to generate the EarnApp UUID which will be used to register and bind to that particular device.

1. Run Earnapp container and inspect the logs: `docker logs earnapp`.
2. You've already generated one or want to re-use that same UUID. Note that each device must have a unique ID.


### Docker run
Run the container, uses Debian base:
```sh
docker run -d \
  --name earnapp \
  -e EARNAPP_UUID=<your_earnapp_uuid> \
  ghcr.io/xterna/earnapp:latest
```

Or use the Alpine variant:
```sh
docker run -d \
  --name earnapp \
  -e EARNAPP_UUID=<your_earnapp_uuid> \
  ghcr.io/xterna/earnapp:alpine
```

Run with a host-mounted folder to persist data across container re-installs:
```sh
docker run -d \
  --name earnapp \
  -e EARNAPP_UUID=<your_earnapp_uuid> \
  -v /etc/earnapp:/etc/earnapp \
  ghcr.io/xterna/earnapp:alpine
```

### Compose
> compose.yml
```yml
services:
    earnapp:
        container_name: earnapp
        image: ghcr.io/xterna/earnapp:alpine
        restart: always
        environment:
            - EARNAPP_UUID=<your_earnapp_uuid>
        volumes:
            - earnapp-data:/etc/earnapp

volumes:
    earnapp-data:
```

```sh
docker compose up -d
````
