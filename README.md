# github-release-uploader

[![GitHub version](https://badge.fury.io/gh/starwarsfan%2Fgithub-release-uploader.svg)](https://badge.fury.io/gh/starwarsfan%2Fgithub-release-uploader) [![HitCount](http://hits.dwyl.io/starwarsfan/https://github.com/starwarsfan/github-release-uploader.svg)](http://hits.dwyl.io/starwarsfan/https://github.com/starwarsfan/github-release-uploader)
[![Docker Stars](https://img.shields.io/docker/stars/starwarsfan/github-release-uploader.svg)](https://hub.docker.com/r/starwarsfan/github-release-uploader/)
[![Docker Pulls](https://img.shields.io/docker/pulls/starwarsfan/github-release-uploader.svg)](https://hub.docker.com/r/starwarsfan/github-release-uploader/)
[![ImageLayers](https://images.microbadger.com/badges/image/starwarsfan/github-release-uploader.svg)](https://microbadger.com/#/images/starwarsfan/github-release-uploader)

Dockerized version of the tool [github-release](https://github.com/aktau/github-release).
With this tool you can upload respectively deploy any kind of artifacts to a release tag on GitHub.

## Facts
* Image is based on official _Alpine Linux_ based [_golang_ image](https://hub.docker.com/_/golang/)
* Additional installed packages:
  * git

## Upload Artifacts to GitHub

### Preparation
Just place the file which should be uploaded into reachable directory.
This directory will be mounted into the container.

Additionally you need a GitHub access token, which should be placed in
the environemt variable _GITHUB_TOKEN_:

```
export GITHUB_TOKEN=1234568790abcdef
```

### Available commands
To see a list of available commands, simply run a container without any
further arguments or call explicitly the _github-release_ tool with the
option `--help`:

```
docker run --rm -it starwarsfan/github-release-uploader:latest github-release --help
```

Regarding detailed usage description, please refer to [_github-release_ GitHub page](https://github.com/aktau/github-release).

### Perfom GitHub upload

To do an upload the usage schema is as follows:

```
docker run \
    --rm \
    -it \
    -e GITHUB_TOKEN=${GITHUB_TOKEN} \
    -v <folder-with-files-to-upload>:/filesToUpload \
    starwarsfan/github-deployer:latest \
    github-release upload \
        --user <GitHub-user-or-organization-name> \
        --repo <GitHub-repo> \
        --tag <tag-on-GitHub-repo> \
        --name <name-of-file-after-upload> \
        --file /filesToUpload/<file-to-upload>
```

All other commands of _github-release_ can be used the same way.

## How to build the image
```
docker build -t starwarsfan/github-release-uploader:latest .
```
