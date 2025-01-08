FROM ubuntu:20.04

RUN apt-get update
RUN apt-get install python3 python3-pip -y
RUN pip3 install --upgrade pip
WORKDIR /app

COPY ./app /app

RUN pip3 install -r requirements.txt


CMD python3 main.py
