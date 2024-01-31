#!/usr/bin/env sh

echo "Starting typo3-documentation-browsersync ..."

docker run --rm -it --pull always \
  -v "./Documentation:/project/Documentation" \
  -v "./Documentation-GENERATED-temp:/project/Documentation-GENERATED-temp" \
  -p 5173:5173 ghcr.io/garvinhicking/typo3-documentation-browsersync:latest

         