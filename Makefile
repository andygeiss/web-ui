BUILD := $(shell git rev-parse --short HEAD)
NAME := $(shell basename "$(PWD)")
VERSION := $(shell git describe --tags)

LDFLAGS=-ldflags "-s -w -X=main.build=$(BUILD) -X=main.name=$(NAME) -X=main.version=$(VERSION)" 

all : test compile run

compile :
	@go build $(LDFLAGS) -o $(GOPATH)/bin/$(NAME) main.go

run :
	@$(GOPATH)/bin/$(NAME)_api

test :
	@go mod tidy
	@go test -v ./...
