# docker-wg-http-proxy
This project is a fork of [wg-http-proxy](https://github.com/shimberger/wg-http-proxy), rebuild with latest packages

## Usage
1. Place `.env`, `compose.yaml` in the same folder

1. Config file: `.env`
    ```
    WG_PUBLIC_KEY=<base64-encoded-key>
    WG_PRIVATE_KEY=<base64-encoded-key>
    WG_LOCAL_IPV4_ADDRESS=<ip>
    WG_DNS_ADDRESS=<ip>
    WG_ENDPOINT=<ip>:<port>
    PROXY_LISTEN_ADDRESS=:8080
    ```

1. Compose file: `compose.yaml`:
    ```
    services:
      wg-http-proxy:
        image: cwlu2001/wg-http-proxy
        container_name: wg-http-proxy
        ports:
          - 8080:8080/tcp
        env_file: .env
    ```

1. Start container with `docker compose up -d`

## Credits
+ https://github.com/shimberger/wg-http-proxy
+ https://github.com/elazarl/goproxy
+ https://git.zx2c4.com/wireguard-go
