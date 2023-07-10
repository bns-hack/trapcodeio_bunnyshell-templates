# Template Overview

This Environment [Template](https://documentation.bunnyshell.com/docs/templates-what-are-templates) is a boilerplate for
creating a new environment for **Meilisearch** full-text search engine.

The template provides the Bunnyshell configuration composed of 3 Components (frontend + backend + database) and the CRUD
application that demonstrates how the components work together to form an environment.

You can extend the template by further adding Components, be them more APIs or other services, such as queues, caches,
block storage etc.

# Environment overview

An [Environment in Bunnyshell](https://documentation.bunnyshell.com/docs/environments) is a user-defined group that
brings together applications and all the services and databases those applications require.

This Environment Template contains 3 components:

- `app` for frontend, based on a `node` image
- `api` for backend, also based on a `rust` image
- `db` using a `mongodb` image

and 1 persistent volume:

- `data-volume`

## Container images

The images for both frontend and backend have 2 possible stages: `debug` and `prod`.

The `dev` stage is suitable for development, as it contains development packages and libraries and has debugging
enabled.  
The `prod` stage is meant for production/staging, as it produces an optimized image, as lightweight as possible.

The stage (`dev` or `prod`) can be set from the Environment's configuration (`bunnyshell.yaml`), within each
Component's `dockerCompose.build.target` property. The default is `dev`, and it can be changed to `prod` to produce
production-like images.

# How to use this Template

You can create Environments from
a [Bunnyshell Template](https://documentation.bunnyshell.com/docs/templates-what-are-templates); these Environments can
have multiple purposes:

- Development
- Staging / Dev testing / End-to-end testing

Development Environments should be created with the `dev` target for images (see "Container images") and can be used for
Remote Development.

Staging / Testing Environments should be created with the `prod` target for images, in order to have the application
running as it does in production.

## Staging / Testing

For staging / testing purposes, the Environments just need to be deployed.

You need to ensure that the `dockerCompose.build.target` is set to `prod` for all the Components, and
then [deploy the Environment](https://documentation.bunnyshell.com/docs/environment-workflows-deploy).


# Important Note

You must change all passwords and review all parameters to ensure that your Environment is secure.

