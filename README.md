# Appointment Sample API

![Appointment Sample API workflow](https://github.com/xistz/appointment-sample-api/workflows/Appointment%20Sample%20API%20workflow/badge.svg)

This repository contains code for the API of the appointment sample service.

Appointment Sample can be accessed at <https://appointment-sample-api.herokuapp.com>

## Available Scripts

In the project directory, you can run:

### `docker-compose build`

Builds the development container

### `docker-compose run --rm api bundle exec rails db:setup RAILS_ENV=development`

Setups database for development

### `docker-compose up`

Starts development server

### `docker-compose run --rm api bundle exec rspec --format-documentation`

Runs tests

## Required ENV variables

### `AUTH0_DOMAIN`

Auth0 domain used for authorization. Excludes trailing slash and https protocol.

### `AUTH0_AUDIENCE`

Auth0 audience refers to the identifier of the API application (dummy URL, not the actual appointment sample API URL).

### `AUTH0_NAMESPACE`

Auth0 namespace refers to the namespace used for roles of the appoint sample service (namespace uses a dummy URL, not an actual URL).

### `AUTH0_CLIENT_ID`

Auth0 Client ID for the Appointment API machine to machine application.

### `AUTH0_CLIENT_SECRET`

Auth0 Client Secret for the Appointment API machine to machine application.

## CI/CD

Tests are run on push to the main branch.
This repository is deployed using GitHub Actions to Heroku.
