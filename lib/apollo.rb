# Dependencies
require 'typhoeus'
require 'typhoeus/adapters/faraday'
require 'ostruct'
require 'faraday'
require 'faraday_middleware'
require 'net/http'
require 'connection_pool'
require 'json'

require "apollo/version"
require "apollo/config"

module Apollo
    def self.options
        @options
    end

    def self.connection
        @connection
    end

    def self.configure(&blk)
        @options = Apollo::Config.new
        yield(@options)

        @connection = ConnectionPool::Wrapper.new(size: @options.pool || 32, timeout: @options.timeout || 10) do
            connection = Faraday.new(:url => @options.host + ":#{@options.port|| 80}") do |builder|
                if @options.log_faraday_responses
                builder.use Faraday::Response::Logger, @options.logger || :logger
                end
                builder.use Faraday::Adapter::Typhoeus
            end
            connection.path_prefix = "/api/v1"
            connection
            end

        # Clients
        require "apollo/clients/base_client"
        require "apollo/clients/accounts"
        require "apollo/clients/indices"

        # Models
        require "apollo/models/base_model"
        require "apollo/models/sanitizer"
    end
end