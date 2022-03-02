#!/usr/bin/env bash

grep -A 1 schedule * | grep cron | cut -d':' -f2 | sed 's/"//g' | sort -u 
