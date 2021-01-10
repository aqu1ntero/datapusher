FROM python:3.8-slim-buster

ENV APP_DIR=/usr/lib/ckan/datapusher
ENV SOURCE_DIR=${APP_DIR}/src/datapusher
ENV WSGI_FILE ${SOURCE_DIR}/deployment/datapusher.wsgi
ENV WSGI_CONFIG ${SOURCE_DIR}/deployment/datapusher-uwsgi-0.0.17.ini

RUN mkdir -p ${SOURCE_DIR}
COPY . ${SOURCE_DIR}
WORKDIR ${SOURCE_DIR}

RUN apt update && apt install -y gcc make g++ libpcre3 libpcre3-dev vim && apt clean
RUN pip install -r requirements.txt
RUN pip install uwsgi==2.0.19.1
RUN python setup.py install

EXPOSE 8800

CMD /usr/local/bin/uwsgi -i ${WSGI_CONFIG}
# CMD [ "python", "datapusher/main.py", "deployment/datapusher_settings.py" ]
