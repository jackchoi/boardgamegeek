require "net/http"

module BoardGameGeek
  class Request
    def initialize(base_url)
      @base_url = base_url
    end

    def get(uri, params = {})
      response = Net::HTTP.get_response(create_uri(uri, params))

      convert_response_to_hash(response)
    end

    private

    def escape(val)
      CGI.escape(val.to_s)
    end

    def create_uri(uri, params = {})
      url = "#{@base_url}/#{escape(uri)}"
      url << "?#{to_query_string(params)}" unless params.empty?

      URI(url)
    end

    def to_query_string(params)
      params.map{ |key, val| to_query_string_pair(key, val) }.join('&')
    end

    def to_query_string_pair(key, val)
      if val.respond_to? :each
        # BGGXML allows comma-separated value to handle multiple values
        escaped_value = val.each { |v| escape(v) }.join(',')
      else
        escaped_value = escape(val)
      end

      "#{escape(key)}=#{escaped_value}"
    end

    def convert_response_to_hash(response)
      {
        :code => response.code.nil? ? nil : response.code.to_i,
        :message => response.message,
        :body => response.body
      }
    end
  end
end
