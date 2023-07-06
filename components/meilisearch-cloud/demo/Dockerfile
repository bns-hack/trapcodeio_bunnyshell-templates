# First stage: clone the repository
FROM alpine/git as clone
WORKDIR /app
RUN git clone https://github.com/meilisearch/ecommerce-demo.git

# Second stage: build the application
FROM node:18
WORKDIR /usr/src/app

COPY --from=clone /app/ecommerce-demo .

# Set the environment variables
ENV MEILISEARCH_HOST="0.0.0.0:7700"
ENV MEILISEARCH_ADMIN_API_KEY="default_master_key"
ENV MEILISEARCH_SEARCH_API_KEY="default_search_api_key"
ENV TWICPICS_DOMAIN="https://meilisearch-ecommerce.twic.pics"
ENV STORYBOOK_TWICPICS_DOMAIN="https://meilisearch-ecommerce.twic.pics"

RUN yarn install

COPY ./start-nuxt.sh .
RUN chmod +x ./start-nuxt.sh

# setup

# Expose the application on port 3000
EXPOSE 3000

# Start the application
CMD ["./start-nuxt.sh"]


