# Durango Lib

Durango Computer FrameWork.

[https://www.durangoretro.com/](https://www.durangoretro.com/)

This repository contains the source code and configuration, needed for generate the Durango Computer FrameWork.

## Install Durango Lib

To use this FrameWork, you can use the next approach:

1. Install in your own machine.
    a. Download the Last Relase from the [Release page](https://github.com/durangoretro/DurangoLib/releases).
    b. unzip in your computer the Zip File.
    c. Create a new Environment Variable ```DDK``` (Durango Dev Kit) that contains the Path where the Zip was unziped.
2. Use a [Docker Image](https://hub.docker.com/r/zerasul/durangodevkit/tags).

```bash
docker pull zerasul/durangodevkit:latest
```

## Compile Durango Lib

To Compile and generate Durango Lib, you need the Next Prerequisites (Only if you don't use Docker Image):

1. Make
2. [CC65](https://cc65.github.io/)
3. Git
4. Curl
5. zip & unzip

After install prerequisites you can compile and generate zipFile

1. Using make

```bash
make
```

2. using Docker

```bash
docker run --rm -v $PWD:/src/durango zerasul/durangodevkit:latest
```


