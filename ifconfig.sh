#!/usr/bin/env bash

echo -n "IP: "
ifconfig | grep 'inet' | grep -v 'inet6'| grep -v '127.0.0.1'| awk -F ' ' '{print $2}'
