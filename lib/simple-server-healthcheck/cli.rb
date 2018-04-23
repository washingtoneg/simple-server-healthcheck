require 'thor'

module SimpleServerHealthcheck
  class CLI < Thor
    desc 'health', 'get health of SERVERS less than AGE'
    long_desc <<-LONGDESC
      Get the health information for a list of servers.
      Server arguments should be in host:port format (e.g. server-1.example.com:8080, server-2.example.com:7070)
      Each server is expected to have an available '/health' endpoint that responds with predefined HTML containing a "Last Updated" timestamp.
      A server is defined to be healthy if and only its "Last Updated" timestamp is less than AGE minutes old.
      Command is set to timeout after 5 minutes if unable to complete in that amount of time.
    LONGDESC
    option :age, type: :numeric, required: true
    option :servers, type: :array, required: true
    def health
      @age = options[:age]
      @servers = options[:servers]

      check_hostname_port
    end

    private

    attr_reader :age, :servers

    def check_hostname_port
      regex = /[^\:]+:[0-9]{2,5}/
      servers.each do |server|
        unless regex =~ server
          raise "#{server} should include a colon followed by a port number"
        end
      end
    end
  end
end
