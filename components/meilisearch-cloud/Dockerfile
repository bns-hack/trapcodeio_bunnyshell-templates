# Stage 1: Builder
FROM debian:bullseye-slim as build

# Set the working directory
WORKDIR /usr/src/app

# Install curl and ca-certificates
RUN apt-get update && apt-get install -y curl ca-certificates

# Download the latest stable release of Meilisearch
RUN curl -L https://install.meilisearch.com | sh

# Stage 2: Development
FROM debian:bullseye-slim as dev

# Set the working directory
WORKDIR /usr/src/app

# Copy the Meilisearch binary from the builder stage
COPY --from=build /usr/src/app/meilisearch ./meilisearch

# Expose the port that Meilisearch uses
EXPOSE 7700

# Start Meilisearch when the container is run, using the environment variables
CMD ["./meilisearch"]

# Stage 3: Production
FROM debian:bullseye-slim as prod

# Set the working directory
WORKDIR /usr/src/app

# Copy the Meilisearch binary from the builder stage
COPY --from=build /usr/src/app/meilisearch ./meilisearch

ENV MEILI_ENV=production

# Expose the port that Meilisearch uses
EXPOSE 7700

# Start Meilisearch when the container is run, using the environment variables
CMD ["./meilisearch", "--no-analytics"]
