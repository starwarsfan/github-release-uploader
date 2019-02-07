FROM golang:1.11.5-alpine3.8
MAINTAINER Yves Schumann <yves@eisfair.org>

# Install git, show Go version and install github-release
RUN apk add git \
 && go version \
 && go get github.com/aktau/github-release

# Create mountpoint for file to upload
RUN mkdir /filesToUpload

# Just show the help to github-release if container is simply started
CMD github-release --help
