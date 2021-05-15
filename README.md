# xSystems - Trezor Suite

> Trezor Suite image build from the [Trezor Suite source code][trezor-suite]


## Build your own version

Clone this repository and use `docker build` whilst leveraging the `--build-arg` option to set the appropiate build-time variables described below.

All available build arguments are:

| Build Argument        | Example Values                 | Required | Description                                                                              |
| :-------------------- | :----------------------------- | :------: | :--------------------------------------------------------------------------------------- |
| TREZOR_SUITE_VERSION  | v21.5.1                        |     ✔    | The [Trezor Suite Git version tag][trezor-suite-tags] to base this image on              |
| ORIGIN_HOSTNAME       | xsystems.org                   |     †    | Hostname of the (top-level) origin a service created from this image will be served from |
| BLOCKBOOK_BITCOIN_URL | https://blockbook.xsystems.org |          | The Blockbook URL for Bitcoin used by Trezor Suite                                                   |
| DISABLE_MONITORING    | true                           |          | Disable monitoring <sup>§</sup>                                                          |
| DISABLE_ANALYTICS     | true                           |          | Disable analytics <sup>§</sup>                                                           |
| DISABLE_NEWS_FEED     | true                           |          | Disable the news feed <sup>§</sup>                                                       |

_† This is required, as well as setting up TLS, to enable [WebUSB][web-usb]_  
_§ Set to `true` to **minimize** the amount of requests made to other origins and the amount of data that is collected_


## Build the Image

Optionally change the variable `DOCKER_TAG` in [build.sh](build.sh) and run that script to build an image of the Trezor Suite codebase state with tag indicated by `DOCKER_TAG`.


## Release the Image

1. Set the `VERSION` environment variable to the version that needs to be released.
2. Optionally, set the `COMMIT` environment variable to the hash of the Git commit that needs to be released. It defaults to the latest commit.
3. Run [release.sh](release.sh).

Example release statement:

```sh
VERSION=v21.5.1 ./release.sh
```

[trezor-suite]: https://github.com/trezor/trezor-suite "Trezor Suite"
[trezor-suite-tags]: https://github.com/trezor/trezor-suite/tags "Trezor Suite Tags"
[web-usb]: https://developer.mozilla.org/en-US/docs/Web/API/USB "WebUSB"