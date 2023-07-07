# First stage: clone the repository
FROM alpine/git as clone
WORKDIR /app
RUN git clone https://github.com/meilisearch/ecommerce-demo.git

# Second stage: build the application
FROM node:18 as setup
WORKDIR /usr/src/app

# Copy package.json and yarn.lock from the first stage
COPY --from=clone /app/ecommerce-demo/package.json .
COPY --from=clone /app/ecommerce-demo/yarn.lock .

RUN yarn install

COPY --from=clone /app/ecommerce-demo .

FROM node:18 as dev
WORKDIR /usr/src/app

COPY --from=setup /usr/src/app .

COPY start-nuxt-dev.sh .
RUN chmod +x ./start-nuxt-dev.sh

# Expose the application on port 3000
EXPOSE 3000

# Start the application
CMD ["./start-nuxt-dev.sh"]

FROM node:18 as prod
WORKDIR /usr/src/app

COPY --from=setup /usr/src/app .

COPY start-nuxt-prod.sh .
RUN chmod +x ./start-nuxt-prod.sh

# Expose the application on port 3000
EXPOSE 3000

# Start the application
CMD ["./start-nuxt-prod.sh"]



