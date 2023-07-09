# Meilisearch Cloud Docker Boilerplate

This template is a simple docker-compose file that will start a Meilisearch instance with persistent data.
It also includes a demo application that shows how to use the Meilisearch API.

## Featured Repositories

- [Meilisearch Ecommerce Demo](https://github.com/meilisearch/ecommerce-demo)

## How to use

- First, you need to have docker and docker-compose installed on your machine.
- Clone this repository
- Run `docker-compose up` in the root of the repository
- Open your browser at `http://localhost:7700` to see the meilisearch dashboard
- Open your browser at `http://localhost:3000` to see the demo application


## How to use with your own application

To use with your own application, comment out the demo application in the `docker-compose.yml` file therefore leaving only the meilisearch service.
Then, in your application, you need to change the meilisearch host to `http://localhost:7700` and you are good to go.