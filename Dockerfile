FROM python:3.6-alpine

ENV PATH="/tmp/**/python/bin:${PATH}"
WORKDIR /app

EXPOSE 8080
EXPOSE 8000

COPY requirements.txt /tmp/requirements.txt

pip install --upgrade pip

RUN apk --update add python py-pip openssl ca-certificates py-openssl wget bash linux-headers
RUN apk --update add --virtual build-dependencies libffi-dev openssl-dev python-dev py-pip build-base \
  && pip install --upgrade pip \
  && pip install --upgrade pipenv\
  && pip install --upgrade -r /tmp/requirements.txt\
  && apk del build-dependencies

COPY . /app
ENV FLASK_APP=server/__init__.py

ENTRYPOINT [ "python" ]

CMD [ "python", "train.py" ]
#CMD [ "run.py" ]
#CMD ["python", "run.py", "start", "0.0.0.0:8000"]
