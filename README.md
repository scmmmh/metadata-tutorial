# DHd-AG-ZZ Metadata Tutorial

This tutorial was developed for the DHd Working Group on Newspapers and Periodicals’ Metadata Workshop 2020.

Build & Deployment status: ![](https://github.com/mmh352/metadata-tutorial/workflows/Build/badge.svg) ![](https://github.com/mmh352/metadata-tutorial/workflows/Deployment/badge.svg)

To run the tutorial locally, the complete tutorial environment is available as a [Docker](https://www.docker.com) image. First install the [Docker Engine](https://www.docker.com/get-started), which is available for Windows, Mac, and Linux. Then run the following command to start the container:

```
docker run --rm -p 127.0.0.1:8888:8888 --volume metadata-tutorial:/home/ou/MetadataTutorial-3: scmmmh/metadatatutorial:latest
```

This will automatically download the required image and start the container. After running the command, when the container has been started, a URL to load the tutorial in the browser will be shown. Copy and paste that into the browser to access the tutorial.

To stop the docker container, press ``Ctrl+C``.

## Development

For development, you need the following pre-requisites:

* Poetry
* Yarn

Then install all dependencies:

```
poetry install
```

## License

The [Metadata Tutorial](https://github.com/mmh352/metadata-tutorial) is licensed under [<img src="https://mirrors.creativecommons.org/presskit/buttons/88x31/png/by-sa.png" alt="CC BY-SA 4.0" height="36"/>](https://creativecommons.org/licenses/by-sa/4.0/)
