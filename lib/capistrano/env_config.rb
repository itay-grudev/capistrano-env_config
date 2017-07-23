require 'capistrano/plugin'

module Capistrano
  class EnvConfig < Capistrano::Plugin

    def define_tasks
      eval_rakefile File.expand_path( '../tasks/env_config.rake', __FILE__ )
    end

    def set_defaults
      set_if_empty :env_config_roles, :all
    end
  end
end

install_plugin Capistrano::EnvConfig

require 'capistrano/env_config/environment'
require 'capistrano/env_config/version'