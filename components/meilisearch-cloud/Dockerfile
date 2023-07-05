# Use a base image with curl installed
FROM debian:bullseye-slim

# Set the working directory
WORKDIR /usr/src/meilisearch

# Install curl and ca-certificates
RUN apt-get update && apt-get install -y curl ca-certificates

# Download the latest stable release of Meilisearch
RUN curl -L https://install.meilisearch.com | sh

# Set a default value for MASTER_KEY
ENV MASTER_KEY=default_master_key

# Expose the port that Meilisearch uses
EXPOSE 7700

# Start Meilisearch when the container is run
CMD ./meilisearch --master-key $MASTER_KEY
