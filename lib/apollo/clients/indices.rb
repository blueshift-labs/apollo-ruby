module Apollo
  def self.indices
    Indices.new;
  end

  class Indices < BaseClient
    def for_index(index)
      Index.new(index)
    end
  end

  class Index < BaseClient
    def initialize index
      @index = index
    end

    def sanitizer(include_defaults: false)
      if include_defaults
        handle_request("sanitizers/#{@index}", :get, params: { include_defaults: true })
      else
        handle_request("sanitizers/#{@index}", :get)
      end
    end

    def update_sanitizer(sanitizer:, override: false)
      handle_request("sanitizers/#{@index}", :put, params: { override: override }, body: sanitizer)
    end

    def run_sanitizer(type:, document:, sanitizer: nil)
      handle_request("sanitize/indices/#{@index}/types/#{type}", :get, body: {
        document: document,
        sanitizer: sanitizer
      }.delete_if { |_, v| v.nil? })
    end
  end
end