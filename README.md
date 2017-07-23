[![Gem Version](https://badge.fury.io/rb/capistrano-env_config.svg)](https://badge.fury.io/rb/capistrano-env_config)

capistrano-env_config
=====================

A tool for managing your environment variables across your cluster. The library
manipulates the system-wide environment variables by modifying the
`/etc/environment` file.

Usage
-----

* `cap env:list` – To list current environment configuration
* `cap env:get[VARIABLE_NAME]` – To get the value of specific variable
* `cap env:unset[VARIABLE_NAME]` – To delete an environment variable
* `cap env:set[VARIABLE_NAME=VALUE]` – To set an environment variable
* `cap env:sync` – To synchronise the environment configuration across servers

If you need to programatically manipulate the environment you can use the
`Capistrano::EnvConfig::Environment` class like so:

```ruby
require 'capistrano/env_config/environment'

environment = Capistrano::EnvConfig::Environment.new
environment.list
environment.get( 'VARIABLE' )
environment.set( 'VARIABLE', 'VALUE' )
environment.delete( 'VARIABLE' )
environment.sync
```

By default capistrano sets and reads the `/etc/environment` of all roles. This
behaviour can be changed by setting:

```ruby
set :env_config_roles, [ :web, :app ]
```

The `list` and `sync` method also accept an optional argument for specifying the
roles explicitly (overriding the value set in `:env_config_roles`):

```ruby
environment.list( :app )
environment.list( [ :web, :app ] )
```

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