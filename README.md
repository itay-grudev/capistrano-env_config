[![Gem Version](https://badge.fury.io/rb/capistrano-env_config.svg)](https://badge.fury.io/rb/capistrano-env_config)

capistrano-env_config
=====================

A tool for managing your environment variables across your cluster. The library
manipulates the system-wide environment variables by modifying the
`/etc/environment` file.

Usage
-----

* `cap env:list` – To list current environment configuration
* `cap env:get[VARIABLE_NAME, VARIABLE_NAME, ...]` – To get the value of a list of variables
* `cap env:unset[VARIABLE_NAME, VARIABLE_NAME, ...]` – To delete environment variables
* `cap env:set[VARIABLE_NAME=VALUE, VARIABLE_NAME=VALUE, ...]` – To set environment variables
* `cap env:sync` – To synchronise the environment configuration across servers

If you need to programatically manipulate the environment you can use the
`Capistrano::EnvConfig::Environment` class like so:

```ruby
require 'capistrano/env_config/environment'

environment = Capistrano::EnvConfig::Environment.new # Reads and loads /etc/environment from all servers
environment.list # Returns a hash of all environment variables
environment.get( 'VARIABLE' ) # Gets a variable by name
environment.set( 'VARIABLE', 'VALUE' ) # Sets a variable
environment.delete( 'VARIABLE' ) # Deletes a variable
environment.sync # Uploads current configuration to all servers
```

By default capistrano sets and reads the `/etc/environment` of all roles. This
behaviour can be changed by setting:

```ruby
set :env_config_roles, [ :web, :app ]
```

The `new` and `sync` methods also accept an optional argument for specifying
roles explicitly (overriding the value set in `:env_config_roles`):

```ruby
environment.list( :app )
environment.sync( [ :web, :app ] )
```

Installation
------------

Add the gem to your `Gemfile`:

```ruby
group :development do
  gem 'capistrano-env_config'
end
```

And the following line to your `Capfile`:

```ruby
require 'capistrano/env_config'
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
