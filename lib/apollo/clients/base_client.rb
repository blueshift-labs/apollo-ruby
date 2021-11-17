module Apollo
  class RequestError < StandardError
  end

  class ConnectionError < StandardError
  end

  class BaseClient
    def handle_request(url, http_verb, params: nil, body: nil)
      result = nil
      Apollo.connection.with do |faraday_connection|
        result = faraday_connection.send(http_verb.to_s) do |request|
          request.url url
          request.headers['Content-Type'] = 'application/json'
          request.params = params unless params.nil?
          request.body = body.to_json unless body.nil?
          request.options[:timeout] = 600
        end
      end
      handle_result(result)
    rescue Faraday::TimeoutError, Faraday::ConnectionFailed => e
      raise ConnectionError, "Apollo connection error: #{e.message}"
    end

    def handle_request_with_headers(url, http_verb, params: nil, body: nil)
      result = nil
      Apollo.connection.with do |faraday_connection|
        result = faraday_connection.send(http_verb.to_s) do |request|
          request.url url
          request.headers['Content-Type'] = 'application/json'
          request.params = params unless params.nil?
          request.body = body.to_json unless body.nil?
          request.options[:timeout] = 600
        end
      end
      body = begin
        JSON.load(result.body)
      rescue StandardError
        nil
      end
      [body, result.headers]
    end

    def handle_result(result)
      if (result.status >= 200 && result.status < 300) || result.status == 404
        JSON.load(result.body)
      else
        raise RequestError, "Apollo error status=#{result.status} #{result.body}"
      end
    end
  end
end
