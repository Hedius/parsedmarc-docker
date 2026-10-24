# Based on https://github.com/patschi/parsedmarc-dockerized/blob/master/data/Dockerfiles/parsedmarc/Dockerfile
# License GPL3
FROM python:3.13-slim

# User and Group ID of the account used for execution
ARG UID=5000
ARG GID=5000

# account for execution
RUN groupadd -r -g $GID pythonRun && \
    useradd -r -g pythonRun -u $UID pythonRun

# msgconvert for Outlook .msg files
RUN apt-get update \
    && apt-get install -y --no-install-recommends libemail-outlook-message-perl \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir -U pip \
    && pip install --no-cache-dir -U "parsedmarc[opensearch]"

USER pythonRun:pythonRun

CMD ["parsedmarc", "-c", "/etc/parsedmarc/config.ini"]