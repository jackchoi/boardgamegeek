require "boardgamegeek/errors"
require "boardgamegeek/parser"
require "boardgamegeek/request"

module BoardGameGeek
  BASE_URL = "http://www.boardgamegeek.com/xmlapi2"

  def self.request
    @request ||= Request.new(BASE_URL)
  end

  def self.parser
    @parser ||= Parser.new
  end

  def self.get(uri, params = {})
    raw_data = request.get(uri, params)
    data = parser.parse(raw_data[:body])
    yield data if block_given?
    data
  end
end