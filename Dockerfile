FROM python:3.8-alpine
LABEL maintainer="Galen Guyer <galen@galenguyer.com>"

RUN apk add tzdata && \
    cp /usr/share/zoneinfo/America/New_York /etc/localtime && \
    echo 'America/New_York' > /etc/timezone && \
    apk del tzdata

RUN mkdir /opt/demo
ADD requirements.txt /opt/demo
WORKDIR /opt/demo
RUN pip install -r requirements.txt
ADD . /opt/demo

CMD ["gunicorn", "demo:APP", "--bind=0.0.0.0:8080", "--access-logfile=-"]
