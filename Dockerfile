FROM python:3.8.16-alpine3.16 as builder

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

RUN apk update \
    && apk add postgresql-dev gcc python3-dev musl-dev

RUN pip install --upgrade pip
COPY ./requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt \
    && find /usr/local \
     \( -type d -a -name test -o -name tests \) \
        -o \( -type f -a -name '*.pyc' -o -name '*.pyo' \) \
        -exec rm -rf '{}' +

FROM python:3.8.16-alpine3.16

RUN mkdir -p /var/www

RUN adduser -S django -G www-data

ENV APP_HOME=/var/www/devopslab/ 
RUN mkdir -p $APP_HOME 
WORKDIR $APP_HOME

RUN apk update && apk add libpq
COPY --from=builder /usr/local/lib/python3.8/site-packages/ /usr/local/lib/python3.8/site-packages/
COPY --from=builder /usr/local/bin/ /usr/local/bin/

COPY . $APP_HOME

RUN chown -R django:www-data $APP_HOME

USER django



