# Use the official Rust image as a base
FROM rust:latest as builder

# Set the working directory
WORKDIR /usr/src/meilisearch

# Clone the Meilisearch repository
RUN git clone https://github.com/meilisearch/meilisearch .

# Check out to the latest version
RUN git checkout latest

# Update Rust
RUN rustup update

# Compile the project
RUN cargo build --release

# Create a new stage with a minimal image
# to reduce the final size
FROM debian:bullseye-slim

# Copy Meilisearch binary to this new stage
COPY --from=builder /usr/src/meilisearch/target/release/meilisearch /usr/bin/meilisearch

# Expose the port that Meilisearch uses
EXPOSE 7700

# Start Meilisearch when the container is run
CMD ["meilisearch"]
