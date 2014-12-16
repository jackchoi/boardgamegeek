require "boardgamegeek/uri_helper"

module BoardGameGeek
  class API
    def initialize(opts)
      @uri_helper = URIHelper.new(opts[:base_url])
      @request_handler = opts[:request_handler]
      @parser = opts[:parser]
    end

    def get(resource_name, params = {})
      raw_data = make_resource_request(resource_name, params)

      data = process_response(raw_data)

      yield data if block_given?
      data
    end

    private

    def make_resource_request(resource_name, params)
      raw_data = @request_handler.get(@uri_helper.resource_to_uri(resource_name, params))

      case raw_data[:status_code].to_s
      when /4\d\d/
        raise InvalidResourceError, %Q(Unknown resource "#{resource_name}")
      when /5\d\d/
        raise APIError, %Q(Unable to request "#{resource_name}" from source)
      end

      raw_data
    end

    def process_response(content)
      @parser.parse(content[:body])
    end
  end
end
