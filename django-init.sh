#!/bin/bash

pip install -r ./app/requirements.txt

python /home/docker/code/app/manage.py collectstatic --noinput