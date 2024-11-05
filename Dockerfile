# Based on https://github.com/patschi/parsedmarc-dockerized/blob/master/data/Dockerfiles/parsedmarc/Dockerfile
# License GPL3
FROM pypy:3-slim

# User and Group ID of the account used for execution
ARG UID=5000
ARG GID=5000

# account for execution
RUN groupadd -r -g $GID  pythonRun && \
    useradd -r -g pythonRun -u $UID pythonRun

RUN apt-get update \
    && apt-get install -y \
        python3-pip python3-dev libxml2-dev libxslt-dev libz-dev libxml2-dev \
        gcc libemail-outlook-message-perl python3-gi python3-gi-cairo \
        gir1.2-secret-1
RUN pip install -U parsedmarc
RUN apt-get purge --yes gcc && apt autoremove --yes && apt-get clean \
    && rm -Rf /var/lib/{apt,dpkg}/ && rm -Rf /root/.cache/

USER pythonRun:pythonRun

CMD ["parsedmarc", "-c", "/etc/parsedmarc/config.ini"]

