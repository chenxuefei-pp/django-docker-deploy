#!/bin/bash

pip3 install -r /home/docker/code/app/requirements.txt

python /home/docker/code/app/manage.py collectstatic --noinput