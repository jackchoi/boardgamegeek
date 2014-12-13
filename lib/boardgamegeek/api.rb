module BoardGameGeek
  class API
    def initialize(opts)
      @base_url = opts[:base_url]
      @request_handler = opts[:request_handler]
      @parser = opts[:parser]
    end

    def get(resource_name, params = {})
      raw_data = @request_handler.get uri_from_resource(resource_name, params)
      case raw_data[:status_code].to_s
      when /4\d\d/
        raise InvalidResourceError, %Q(Unknown resource "#{resource_name}")
      when /5\d\d/
        raise APIError, %Q(Unable to request "#{resource_name}" from source)
      else
        data = @parser.parse(raw_data[:body])
        yield data if block_given?
        data
      end
    end

    private

    def uri_from_resource(resource_name, params = {})
      url = "#{@base_url}/#{escape(resource_name)}"
      url << "?#{params_to_query_string(params)}" unless params.empty?

      URI(url)
    end

    def params_to_query_string(params)
      params.map{ |key, val| param_to_query_string_pair(key, val) }.join('&')
    end

    def param_to_query_string_pair(key, val)
      escaped_value = case val
                      when Enumerable
                        # BGGXML allows comma-separated value to handle non-scalar values
                        val.each { |v| escape(v) }.join(',')
                      when TrueClass
                        "1"
                      when FalseClass
                        "0"
                      else
                        escape(val)
                      end

      "#{escape(key)}=#{escaped_value}"
    end

    def escape(val)
      CGI.escape(val.to_s)
    end
  end
end
