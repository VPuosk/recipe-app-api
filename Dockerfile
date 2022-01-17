FROM python:3.10-alpine
LABEL maintainer="Vesa"

# Recommended for running python in container
ENV PYTHONUNBUFFERED 1

# Make sure to copy over & install the requirements
COPY ./requirements.txt /requirements.txt
RUN apk add --update --no-cache postgresql-client
RUN apk add --update --no-cache --virtual .temp-build-deps \
      gcc libpq-dev libc-dev linux-headers postgresql-dev
RUN pip install -r /requirements.txt
RUN apk del .temp-build-deps

# Copy over the code
RUN mkdir /app
WORKDIR /app
COPY ./app /app

# Security purposes
RUN adduser -D user
USER user