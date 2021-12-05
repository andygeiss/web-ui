@echo off
cls
setlocal EnableDelayedExpansion

set NAME=web-ui

echo getting info from Git ...
git pull
git rev-parse --short HEAD > build.txt
set /p BUILD=<build.txt
git describe --tags > version.txt
set /p VERSION=<version.txt
echo.

echo NAME    = %NAME%
echo BUILD   = %BUILD%
echo VERSION = %VERSION%
echo.

echo start building ...
go mod tidy
go test -v ./...
go build --ldflags "-s -w -X=main.build=%BUILD% -X=main.name=%NAME% -X=main.version=%VERSION%" -o %GOPATH%\bin\%NAME%.exe main.go

echo cleaning up ...
del build.txt version.txt

echo running ...
%GOPATH%\bin\%NAME%.exe

echo.
echo done.
