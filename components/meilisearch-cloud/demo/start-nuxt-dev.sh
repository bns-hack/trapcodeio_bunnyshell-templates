#!/bin/sh

# sleep for 5 seconds to wait for meilisearch to start
sleep 5

# Setup
yarn run setup

# change env variables because nuxt can't access `meilisearch:7700` host
export MEILISEARCH_HOST=$MEILISEARCH_EXTERNAL_HOST
echo "Build with MEILISEARCH_HOST=$MEILISEARCH_HOST"

# yarn run preview
yarn run dev