FROM python:3.9-alpine3.13
LABEL maintainer="hdjohnson-dev-online"

ENV PYTHONBUFFERED=1

COPY requirements.txt /tmp/requirements.txt
COPY requirements.dev.txt /tmp/requirements.dev.txt
COPY . /app
WORKDIR /app
EXPOSE 8000

ARG DEV=false
RUN python3 -m venv /env && \
    /env/bin/pip install --upgrade pip && \
    /env/bin/pip install -r /tmp/requirements.txt && \
    if [ $DEV = "true" ]; \
        then /env/bin/pip install -r requirements.dev.txt ; \
    fi && \
    rm -rf /tmp && \
    adduser \
        --disabled-password \
        --no-create-home \
        django-user

ENV PATH="/env/bin:$PATH"

USER django-user
