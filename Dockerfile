FROM python:3.8.16-alpine3.16 as builder

WORKDIR /app

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

RUN apk update \
    && apk add postgresql-dev gcc python3-dev musl-dev

RUN pip install --upgrade pip
COPY ./requirements.txt .
RUN pip wheel --no-cache-dir --no-deps --wheel-dir /app/wheels -r requirements.txt

COPY . . 


FROM python:3.8.16-alpine3.16

RUN mkdir -p /var/www

RUN adduser -S django -G www-data

ENV HOME=/var/www/
ENV APP_HOME=/var/www/devopslab/
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

RUN apk update && apk add libpq
COPY --from=builder /app/wheels /wheels
COPY --from=builder /app/requirements.txt .
RUN pip install --no-cache /wheels/*

COPY . $APP_HOME

RUN chown -R django:www-data $APP_HOME

USER django



