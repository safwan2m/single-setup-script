#!/bin/bash

apt install tuned
cp realtime-variables.conf /etc/tuned/realtime-variables.conf

tuned-adm profile realtime

tuned-adm profile
