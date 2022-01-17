FROM python:3.10-alpine
LABEL maintainer="Vesa"

# Recommended for runnin python in container
ENV PYTHONUNBUFFERED 1

# Make sure to copy over & install the requirements
COPY ./requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

# Copy over the code
RUN mkdir /app
WORKDIR /app
COPY ./app /app

# Security purposes
RUN adduser -D user
USER user