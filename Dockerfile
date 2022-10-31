# Dockerfile
# docker build -t lovellfelix-ohmyrss:latest .
# docker run -d -p 8080:8080 --name ohmyrss lovellfelix-ohmyrss
FROM golang:1.13 As builder

ARG VERSION

COPY . /go/src/github.com/lovellfelix/ohmyrss

WORKDIR /go/src/github.com/lovellfelix/ohmyrss

RUN go get -v /go/src/github.com/lovellfelix/ohmyrss

RUN CGO_ENABLED=0 GOOS=linux \ 
      go build -a -installsuffix \
      cgo -o ohmyrss /go/src/github.com/lovellfelix/ohmyrss

FROM alpine:3.11

WORKDIR /root/

COPY --from=builder /go/src/github.com/lovellfelix/ohmyrss/ohmyrss  .

# Server port to listen
ENV PORT 8080

ENTRYPOINT ["./ohmyrss"]

EXPOSE ${PORT}
CMD [""]