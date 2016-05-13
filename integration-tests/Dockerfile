FROM python:2-alpine

COPY requirements.txt /integration-tests/

WORKDIR /integration-tests

RUN pip install --no-cache-dir -r requirements.txt && rm requirements.txt && \
    apk update && apk add curl git && \
    git clone https://github.com/podshumok/python-smpplib.git && \
    cd python-smpplib && \
    python setup.py sdist && \
    cd .. && \
    pip install python-smpplib/dist/python-smpplib-1.0.1.tar.gz && \
    rm -rf python-smpplib
