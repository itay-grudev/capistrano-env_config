require 'capistrano/env_config/environment'

namespace :env do
  desc 'Lists the environment variables set across servers'
  task :list do
    environment = Capistrano::EnvConfig::Environment.new
    environment.list.each do |key, value|
      puts key + '=' + value
    end
  end

  desc 'Synchronizes the environment variables across servers'
  task :sync do
    environment = Capistrano::EnvConfig::Environment.new
    environment.sync
  end

  desc 'Sets an environment variable'
  task :set, :variable do |task, args|
    abort 'No key-value pair specified.' if args[:variable].nil?
    key, value = args[:variable].split( '=', 2 )
    environment = Capistrano::EnvConfig::Environment.new
    environment.set( key, value )
    environment.sync
  end

  desc 'Prints an environment variable'
  task :get, :variable do |task, args|
    environment = Capistrano::EnvConfig::Environment.new
    variable = environment.get( args[:variable] )
    if variable.nil?
      abort "No such variable: #{args[:variable].upcase}"
    else
      puts "#{args[:variable].upcase}=#{variable}"
    end
  end

  desc 'Removes a environment variable'
  task :unset, :variable do |task, args|
    environment = Capistrano::EnvConfig::Environment.new
    if environment.get( args[:variable].upcase ).nil?
      abort "No such variable: #{args[:variable].upcase}"
    else
      environment.delete( args[:variable].upcase )
      environment.sync
    end
  end
end
