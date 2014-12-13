require "boardgamegeek/errors"
require "boardgamegeek/parser"
require "boardgamegeek/request"
require "boardgamegeek/api"
require "boardgamegeek/resource"

module BoardGameGeek
  BASE_URL = "http://www.boardgamegeek.com/xmlapi2"

  def self.request_handler
    @request ||= Request.new
  end

  def self.parser
    @parser ||= Parser.new
  end

  def self.api_handler
    @api_handler = API.new :base_url => BASE_URL,
                           :request_handler => request_handler,
                           :parser => parser
  end

  autoload :Thing, "boardgamegeek/resource/thing"
end