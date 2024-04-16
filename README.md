# GaGaNode Docker

### Containerised docker image for [GaGaNode](https://gaganode.com)

>**Note:** This is an unofficial build and comes with no warranty of any kind. By using this image you also agree to GaGaNode's T&C.

This is a simple Docker image for installing GaGaNode as a container.

## Usage
Define the following environment variable to bootstrap the image.

Variable | Description | Mandatory |
| :---: | :---: | :---: |
| TOKEN | Your GaGaNode token | YES |

---
### Docker Compose
Via `compose.yml`
```yaml
version: '3'

services:
  spide:
    container_name: gaga-node
    image: xterna/gaga-node
    restart: unless-stopped
    dns:
        - 1.1.1.1
        - 8.8.8.8
```
```yaml
docker compose up -d
```

### Docker run
```yaml
docker run -d --restart unless-stopped --name gaga-node -e TOKEN=<YOUR_TOKEN> xterna/gaga-node
```
This will start the application in the background. The alias assigned is `spide`.
