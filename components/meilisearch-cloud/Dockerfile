# Use a base image with curl installed
FROM debian:bullseye-slim

# Set the working directory
WORKDIR /usr/src/meilisearch

# Install curl and ca-certificates
RUN apt-get update && apt-get install -y curl ca-certificates

# Download the latest stable release of Meilisearch
RUN curl -L https://install.meilisearch.com | sh

# Set a default value for MASTER_KEY and MEILI_HTTP_ADDR
ENV MEILI_MASTER_KEY=default_master_key
ENV MEILI_HTTP_ADDR=0.0.0.0:7700

# Expose the port that Meilisearch uses
EXPOSE 7700

# Start Meilisearch when the container is run
CMD ./meilisearch --master-key $MEILI_MASTER_KEY --http-addr $MEILI_HTTP_ADDR
