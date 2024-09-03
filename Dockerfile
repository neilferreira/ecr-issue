FROM --platform=linux/amd64 python:3.12.2-slim

RUN mkdir /opt/application
WORKDIR /opt/application

COPY code.py ./

RUN echo "foo"
