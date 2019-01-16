#!/bin/bash

set -euo


# Restore original default config if no config has been provided
if [[ ! "$(ls -A /etc/nginx/conf.d)" ]]; then
  echo "Copy config template"
  mkdir -p /etc/nginx/conf.d
  cp -a /etc/nginx/conf.d.orig/* /etc/nginx/conf.d 2>/dev/null
fi

# Replace variables $ENV{<environment varname>}
function ReplaceEnvironmentVariable() {
  grep -rl "\$ENV{\"$1\"}" $3|xargs -r \
    sed -i "s|\\\$ENV{\"$1\"}|$2|g"
  }

if [ -n "${DEBUG-}"  ]; then
  echo "Environment variables:"
  env
  echo "..."
fi


echo "Replace vars"
# Replace all variables
for _curVar in `env | awk -F = '{print $1}'`;do
  # awk has split them by the equals sign
  # Pass the name and value to our function
  ReplaceEnvironmentVariable ${_curVar} ${!_curVar} /etc/nginx/conf.d/*
done

echo "Starting nginx"

/usr/sbin/nginx -g 'daemon off;'
