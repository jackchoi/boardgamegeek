require "boardgamegeek/errors"
require "boardgamegeek/result"
require "boardgamegeek/configuration"
require "boardgamegeek/parser"
require "boardgamegeek/request"
require "boardgamegeek/marshaller"
require "boardgamegeek/api"

module BoardGameGeek
  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.reset
    @configuration = Configuration.new
  end

  def self.configure
    yield configuration
  end

  def self.api_handler
    @api_handler ||= API.new :base_url => configuration.base_url,
                             :request_handler => configuration.request_handler,
                             :parser => configuration.parser,
                             :marshaller => @marshaller
  end

  @marshaller = Marshaller.new

  autoload :Resource, "boardgamegeek/resource"
  autoload :Thing,    "boardgamegeek/resource/thing"
end
