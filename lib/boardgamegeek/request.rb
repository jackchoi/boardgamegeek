require "net/http"

module BoardGameGeek
  class Request
    def self.get(uri, params = {})
      get_response create_uri(uri, params)
    end

    private

    def self.create_uri(uri, params = {})
      url = "#{BoardGameGeek::BASE_URL}/#{CGI.escape(uri.to_s)}"
      url << "?#{to_query_string(params)}" unless params.empty?

      URI(url)
    end

    def self.to_query_string(params)
      params.map { |key, val|
        if val.respond_to? :map
          # BGGXML allows comma-separated value to handle multiple values
          escaped_value = val.each { |v| CGI.escape(v.to_s) }.join(',')
        else
          escaped_value = CGI.escape(val.to_s)
        end

        "#{CGI.escape(key.to_s)}=#{escaped_value}"
      }.join('&')
    end

    def self.get_response(uri, params = {})
      response = Net::HTTP.get_response(uri)
      convert_response_to_hash(response)
    end

    def self.convert_response_to_hash(response)
      {
        :code => response.code.nil? ? nil : response.code.to_i,
        :message => response.message,
        :body => response.body
      }
    end
  end
end
