# Predios

Assistant for a special territory in my city.

[![Build Status](https://travis-ci.org/mjacobus/predios.svg?branch=master)](https://travis-ci.org/mjacobus/predios)
[![Maintainability](https://api.codeclimate.com/v1/badges/5b75122bc3940aee70d9/maintainability)](https://codeclimate.com/github/mjacobus/predios/maintainability)

## Setup

How to run tests:

```
% bundle exec rake
```

How to run the development console:

```
% bundle exec hanami console
```

How to run the development server:

```
% bundle exec hanami server
```

How to prepare (create and migrate) DB for `development` and `test` environments:

```
% bundle exec hanami db prepare

% HANAMI_ENV=test bundle exec hanami db prepare
```

Explore Hanami [guides](http://hanamirb.org/guides/), [API docs](http://docs.hanamirb.org/1.3.0/), or jump in [chat](http://chat.hanamirb.org) for help. Enjoy! 🌸
