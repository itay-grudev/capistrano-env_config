v0.0.5
------

* `env:list` now outputs the enironment variables sorted.

v0.0.4
------

* Bug Fix: Call to an unnecesarry external library

v0.0.3
------

* Added support for specifying multiple environment variables.

v0.0.2
------

* Removed development dependency on `gem 'rake'`
* Improved gem description. Added documentation about programatic use.
* Added configuration option for roles that env_config sets/reads the
    environment variables from.
* Added an argument for specifically setting roles when using the `Environment`
    class programatically.
* Note: Implemented using the potentially unstable and subject to change
    `Capistrano::Plugin` API.

v0.0.1
------

* Initial version.
