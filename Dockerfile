FROM golang:1.15

ARG RMRVERSION=4.5.2
RUN wget --content-disposition https://packagecloud.io/o-ran-sc/release/packages/debian/stretch/rmr_${RMRVERSION}_amd64.deb/download.deb && dpkg -i rmr_${RMRVERSION}_amd64.deb
RUN wget --content-disposition https://packagecloud.io/o-ran-sc/release/packages/debian/stretch/rmr-dev_${RMRVERSION}_amd64.deb/download.deb && dpkg -i rmr-dev_${RMRVERSION}_amd64.deb
RUN mkdir -p /ws
WORKDIR "/ws"

COPY . /ws
RUN ldconfig
RUN GO111MODULE=on GO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o hw-app hwApp.go
#CMD RMR_SEED_RT=config/uta_rtg.rt ./hw-app -f config/test-config.json
CMD RMR_SEED_RT=config/uta_rtg.rt ./hw-app -f config/config-file.json
