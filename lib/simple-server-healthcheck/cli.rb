require 'nokogiri'
require 'open-uri'
require 'thor'
require 'timeout'

module SimpleServerHealthcheck
  HEALTH_ENDPOINT = 'health'.freeze
  SERVER_REGEX = /[^\:]+:[0-9]{2,5}/
  TIMEOUT_SECONDS = (5 * 60)
  class CLI < Thor
    desc 'health', 'get health of SERVERS based on AGE'
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

      iterate_over_server_list
      puts @health_list
    end

    private

    attr_reader :age, :health_list, :server, :servers

    def check_host_port
      raise host_port_error_message unless SERVER_REGEX =~ @server
    end

    def current_time
      Time.now.strftime('%s').to_i
    end

    def host_port_error_message
      "#{@server} should be in the format HOST:PORT"
    end

    def iterate_over_server_list
      @servers.each do |server|
        begin
          Timeout.timeout(TIMEOUT_SECONDS) do
            @server = server
            check_host_port
            server_health
          end
        rescue Timeout::Error
          raise "Health check took longer than #{TIMEOUT_SECONDS} seconds"
        end
      end
    end

    def page
      Nokogiri::HTML(open("http://#{@server}/#{HEALTH_ENDPOINT}")).css('b').text
    end

    def server_health
      last_updated_timestamp = Time.parse(page).strftime('%s').to_i
      if current_time.to_i - last_updated_timestamp.to_i > (@age * 60)
        update_health_list 'unhealthy'
      else
        update_health_list 'healthy'
      end
    rescue Errno::ECONNREFUSED, OpenURI::HTTPError
      update_health_list 'unhealthy'
    end

    def update_health_list(status)
      @health_list[@server.to_s] = status
    end
  end
end
