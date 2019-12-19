#!/bin/sh
set -e
bundle install --deployment --path ${BUNDLE_PATH}
exec "$@"