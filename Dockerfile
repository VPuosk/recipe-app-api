FROM python:3.10-alpine
LABEL maintainer="Vesa"

# Recommended for running python in container
ENV PYTHONUNBUFFERED 1

# Make sure to copy over & install the requirements
COPY ./requirements.txt /requirements.txt
# Permanent dependencies
RUN apk add --update --no-cache postgresql-client jpeg-dev libjpeg zlib
# Temporary dependencies
RUN apk add --update --no-cache --virtual .temp-build-deps \
      gcc libpq-dev libc-dev linux-headers postgresql-dev \
      musl-dev zlib-dev
RUN pip install -r /requirements.txt
RUN apk del .temp-build-deps

# Copy over the code
RUN mkdir /app
WORKDIR /app
COPY ./app /app

# Directories for holding files
RUN mkdir -p /vol/web/media
RUN mkdir -p /vol/web/static

# Security purposes
RUN adduser -D user
# Access rights must be given before switching to user
RUN chown -R user:user /vol/
RUN chmod -R 755 /vol/web
# Now user can be changed
USER user