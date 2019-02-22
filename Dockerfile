FROM ubuntu:18.04

MAINTAINER Ray Sutton "ray.sutton@gmail.com"

RUN apt-get update -y && \
    apt-get install -y python-pip python-dev

ADD . /app
WORKDIR /app
RUN pip install -r requirements.txt
EXPOSE 5000
CMD ["python", "app.py"]
