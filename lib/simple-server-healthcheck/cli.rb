require 'nokogiri'
require 'open-uri'
require 'thor'

module SimpleServerHealthcheck
  SERVER_REGEX = /[^\:]+:[0-9]{2,5}/
  HEALTH_ENDPOINT = 'health'.freeze
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
      @server = ''
      @health_list = {}

      servers.each do |server|
        @server = server
        check_host_port
        server_health
      end

      puts @health_list
    end

    private

    attr_reader :age, :health_list, :server, :servers

    def check_host_port
      raise host_port_error_message unless SERVER_REGEX =~ @server
    end

    def host_port_error_message
      "#{@server} should be in the format HOST:PORT"
    end

    def server_health
      Nokogiri::HTML(open("http://#{@server}/#{HEALTH_ENDPOINT}"))
    rescue Errno::ECONNREFUSED
      update_health_list 'unhealthy'
    end

    def update_health_list(status)
      @health_list[@server.to_s] = status
    end
  end
end
