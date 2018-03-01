require_relative '../env_config/environment'

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
  task :set do |task, args|
    abort 'No key-value pair specified.' if args.extras.empty?
    environment = Capistrano::EnvConfig::Environment.new
    args.extras.each do |variable|
      key, value = variable.split( '=', 2 )
      environment.set( key, value )
    end
    environment.sync
  end

  desc 'Prints an environment variable'
  task :get do |task, args|
    environment = Capistrano::EnvConfig::Environment.new
    args.extras.each do |variable|
      value = environment.get( variable )
      if value.nil?
        STDERR.puts "No such variable: #{variable.upcase}"
      else
        puts "#{variable.upcase}=#{value}"
      end
    end
  end

  desc 'Removes a environment variable'
  task :unset do |task, args|
    environment = Capistrano::EnvConfig::Environment.new
    args.extras.each do |variable|
      if environment.get( variable.upcase ).nil?
        abort "No such variable: #{variable.upcase}"
      else
        environment.delete( variable.upcase )
      end
    end
    environment.sync
  end
end
