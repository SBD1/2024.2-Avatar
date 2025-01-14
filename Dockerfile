#Usado para instalar as dependências (libs) do projeto

FROM ubuntu:20.04

RUN apt-get update
RUN apt-get install python3 python3-pip -y
RUN pip3 install --upgrade pip
WORKDIR /app

COPY ./app/requirements.txt /app/requirements.txt

RUN pip3 install -r requirements.txt

