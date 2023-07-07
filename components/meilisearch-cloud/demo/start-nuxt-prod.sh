#!/bin/sh

# change env variables because nuxt can't access `meilisearch:7700` host
# store current host in a local variable named `SEARCH_HOST`
export SEARCH_HOST=$MEILISEARCH_HOST
export MEILISEARCH_HOST=$MEILISEARCH_NUXT_HOST
echo "Build with MEILISEARCH_HOST=$MEILISEARCH_HOST"

# Build
yarn run build

# Revert host changes
export MEILISEARCH_HOST=$SEARCH_HOST
echo "Run with MEILISEARCH_HOST=$MEILISEARCH_HOST"

# Setup
yarn run setup

# yarn run preview
yarn run preview
