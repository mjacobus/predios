# Predios

Assistant for a special territory in my city.

[![Build Status](https://travis-ci.org/mjacobus/predios.svg?branch=master)](https://travis-ci.org/mjacobus/predios)
[![Maintainability](https://api.codeclimate.com/v1/badges/5b75122bc3940aee70d9/maintainability)](https://codeclimate.com/github/mjacobus/predios/maintainability)
[![Coverage Status](https://coveralls.io/repos/github/mjacobus/predios/badge.svg?branch=master)](https://coveralls.io/github/mjacobus/predios?branch=master)

## Setup


Link the sample files. If you need to change, copy it instead

```
ln -s env.development.sample env.development
ln -s env.test.sample env.test

# or

cp env.development.sample env.development
cp env.test.sample env.test
```

How to run tests:

```
% bundle exec rspec
```

How to run the development console:

```
% bundle exec hanami console
```

How to run the development server:

```
% bunlde exec hanami server

# or, if you are offline need cdn files to be local

% LOCLAL_ASSETS=true bundle exec hanami server
```

How to prepare (create and migrate) DB for `development` and `test` environments:

```
% bundle exec hanami db prepare

% HANAMI_ENV=test bundle exec hanami db prepare
```

Explore Hanami [guides](http://hanamirb.org/guides/), [API docs](http://docs.hanamirb.org/1.3.0/), or jump in [chat](http://chat.hanamirb.org) for help. Enjoy! 🌸

## Tools

- https://github.com/danklammer/bytesize-icons
- https://getbootstrap.com/docs/4.1/components/buttons/
- https://github.com/threepointone/glamor
- https://parceljs.org/


## Tips

### Dotenv loading

Hanami first loads env, and then .env.{environment}. First to set env wins
