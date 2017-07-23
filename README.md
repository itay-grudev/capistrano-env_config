[![Gem Version](https://badge.fury.io/rb/capistrano-env_config.svg)](https://badge.fury.io/rb/capistrano-env_config)

capistrano-env_config
=====================

A tool for managing your environment variables across your cluster.

Usage
-----

* `cap env:list` – To list current environment configuration
* `cap env:get[VARIABLE_NAME]` – To get the value of specific variable
* `cap env:unset[VARIABLE_NAME]` – To delete an environment variable
* `cap env:set[VARIABLE_NAME=VALUE]` – To set an environment variable
* `cap env:sync` – To synchronise the environment configuration across servers

Installation
------------

Add the gem to your Gemfile:

```gemfile
group :development do
  gem 'capistrano-env_config'
end
```

In your server provisioning script, make sure the deploy user has write access
to the `/etc/environment` file, which is used to store the configured variables.

The simplest way to do that would be to:

```bash
chown :deploy /etc/environment
chmod g+w /etc/environment
```

License
-------

Copyright Itay Grudev (c) 2017.

This gem and all associated documentation is distributed under the terms of the
GNU GPL v3 license.