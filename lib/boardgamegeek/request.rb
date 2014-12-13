require "net/http"

module BoardGameGeek
  class Request
    def get(uri)
      response = Net::HTTP.get_response(uri)

      convert_response_to_hash(response)
    end

    private
    
    def convert_response_to_hash(response)
      {
        :code => response.code.nil? ? nil : response.code.to_i,
        :message => response.message,
        :body => response.body
      }
    end
  end
end
