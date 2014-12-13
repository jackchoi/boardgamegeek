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
        :status_code => response.code.nil? ? nil : response.code.to_i,
        :status_message => response.message,
        :body => response.body
      }
    end
  end
end
