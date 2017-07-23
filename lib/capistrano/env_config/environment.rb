module Capistrano
  module EnvConfig
    class Environment
      class KeyNotSpecified < RuntimeError; end

      BLANK_RE = /\A[[:space:]]*\z/

      def initialize
        variables = { }

        # Acquire all configuration variables and store them in a dictionary (hash)
        on roles( :all ) do
          output = capture( 'cat /etc/environment' )
          output.each_line do |line|
            captures = line.match( /\s*([A-Z_][A-Z0-9_]*)=(.*)/ )
            if captures&.length == 3
              variables[ captures[1] ] = captures[2]
            end
          end
        end
        @variables = variables
      end

      def get( key )
        raise KeyNotSpecified.new if BLANK_RE === key
        return @variables[ key.to_s.upcase ]
      end

      def list
        @variables
      end

      def set( key, value )
        raise KeyNotSpecified.new if BLANK_RE === key
        @variables[ key.to_s.upcase ] = value.to_s
      end

      def delete( key )
        raise KeyNotSpecified.new if BLANK_RE === key
        @variables.delete( key.to_s.upcase )
      end

      def sync
        # Concatenate all variables and output them in the appropariate format
        environment = ''
        @variables.each do |key, value|
          environment += "#{key.upcase}=#{value}\n"
        end

        # Upload the variables to all servers
        on roles( :all ) do
          contents = StringIO.new( environment, 'r' )
          upload! contents, '/etc/environment'
        end
      end
    end
  end
end