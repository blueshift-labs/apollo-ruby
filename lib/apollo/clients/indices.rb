module Apollo
  def self.indices; Indices.new; end

  class Indices < BaseClient
    def for_index(index)
      Index.new(index)
    end
  end

  class Index < BaseClient
    def initialize index
      @index = index
    end

    def sanitizer
      handle_request("sanitizers/#{@index}", :get)
    end

    def update_sanitizer(sanitizer:, override:false)
      handle_request("sanitizers/#{@index}", :put, params: {override: override}, body: sanitizer)
    end
  end
end