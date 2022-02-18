#!/bin/bash
if [[ $(docker ps -a -q) ]]; then
    docker stop $(docker ps -a -q);
fi
