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
services:
  gaganode:
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
```sh
docker run -d --restart unless-stopped --name gaga-node -e TOKEN=<YOUR_TOKEN> xterna/gaga-node
```
This will start the application in the background. The alias assigned is `gaga-node`.

## Like my work?
Donations are warmly welcomed no matter how small and thank you very much. 😌
- **Bitcoin (BTC)** - `bc1qq993w3mxsf5aph5c362wjv3zaegk37tcvw7rl4`
- **Ethereum (ETH)** - `0x2601B9940F9594810DEDC44015491f0f9D6Dd1cA`
- **Binance (BNB)** - `bnb1dj3l3fp24z05vtwtjpaatjyz9sll4elu9lkjww`
- **Binance Smart Chain (BSC)** - `0x2601B9940F9594810DEDC44015491f0f9D6Dd1cA`
- **Solana (SOL)** - `Ap5aiAbnsLtR2XVJB3sp37qdNP5VfqydAgUThvdEiL5i`
- **PayPal** - [@xterna](https://paypal.me/xterna)
