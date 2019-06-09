FROM golang:1.12-alpine as builder

## prepare dep
ENV DEP_VERSION="0.5.1"
RUN apk add --no-cache git curl gcc libc-dev && \
	curl -L -s https://github.com/golang/dep/releases/download/v${DEP_VERSION}/dep-linux-amd64 -o $GOPATH/bin/dep && \
	chmod +x $GOPATH/bin/dep

## go get & install
RUN go get github.com/linkedin/Burrow && \
    cd $GOPATH/src/github.com/linkedin/Burrow && \
	dep ensure && \
	go build -o /tmp/burrow .

###

FROM iron/go

WORKDIR /app
COPY --from=builder /tmp/burrow /app/

ADD /start-burrow.sh /app
RUN chmod +x /app/start-burrow.sh

ADD /burrow.toml /etc/burrow/

CMD ["/app/start-burrow.sh"]
