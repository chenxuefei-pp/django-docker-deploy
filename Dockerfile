# For Version Python 3.6 and Debian 8.0

FROM python:3.6

MAINTAINER ChenXuefei

# COPY requirements.txt and RUN pip install BEFORE adding the rest of your code, this will cause Docker's caching mechanism
# to prevent re-installing (all your) dependencies when you made a change a line or two in your app.

# add (the rest of) our code
COPY . /home/docker/code/

# update apt source and pip source by copy file
RUN mv /etc/apt/sources.list /etc/apt/sources.list.bk && \
	cp /home/docker/code/sources.list /etc/apt/sources.list && \
	mkdir -p /root/.pip && \
	cp /home/docker/code/pip.conf /root/.pip/pip.conf

# Install required packages and remove the apt packages cache when done.

RUN apt-get update -y && \
    apt-get install -y --force-yes \
	git \
	supervisor && \
	pip3 install -U pip setuptools && \
	pip3 install uwsgi && \
  rm -rf /var/lib/apt/lists/*

# install django, normally you would remove this step because your project would already
# be installed in the code/app/ directory
# RUN django-admin.py startproject website /home/docker/code/app/

RUN pip3 install -r /home/docker/code/requirements.txt

EXPOSE 9090
CMD ["bash", "/home/docker/code/entrypoint.sh"]
