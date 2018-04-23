require 'thor'
require 'simple-server-healthcheck/version'

module SimpleServerHealthcheck
  class CLI < Thor
    desc 'hello NAME', 'say hello to NAME'
    option :name, default: 'World', type: :string, required: false
    def hello(name = 'World')
      @stdout.puts "Hello, #{name}. Welcome to simple-server-healthcheck"
    end
  end
end
