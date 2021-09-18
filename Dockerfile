# syntax=docker/dockerfile:1

##
## Build
##
FROM golang:1.17 AS build

WORKDIR /app

COPY go.mod ./
RUN go mod download

COPY . ./

RUN go build -o /http-echo

##
## Deploy
##
FROM gcr.io/distroless/base-debian10

WORKDIR /

COPY --from=build /http-echo /http-echo

EXPOSE 5678

ENTRYPOINT ["./http-echo"]
