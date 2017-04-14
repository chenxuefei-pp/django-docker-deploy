#!/bin/bash
python /home/docker/code/app/manage.py collectstatic <<-EOF
yes
EOF