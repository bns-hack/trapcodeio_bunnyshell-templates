# sleep for 5 seconds to wait for meilisearch to start
sleep 5

# Setup
yarn run setup

# Start
# change env variables
export MEILISEARCH_HOST=$MEILISEARCH_EXTERNAL_HOST
# Build
yarn run build

yarn run preview
```