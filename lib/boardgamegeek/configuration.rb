module BoardGameGeek
  class Configuration
    attr_accessor :base_url
    attr_writer :request_handler, :parser

    def initialize
      @base_url = "http://www.boardgamegeek.com/xmlapi2"
    end

    def request_handler
      @request_handler ||= Request.new
    end

    def parser
      @parser ||= Parser.new
    end
  end
end
