require "spec_helper"

describe BoardGameGeek do
  class FakeParser
  end

  class FakeRequestHandler
  end

  describe "::configure" do
    before :all do
      BoardGameGeek.configure do |config|
        config.base_url = "http://www.example.com"
        config.parser = FakeParser.new
        config.request_handler = FakeRequestHandler.new
      end
    end

    it "returns the proper base_url" do
      expect(BoardGameGeek.configuration.base_url).to eq("http://www.example.com")
    end

    it "returns the proper Parser object" do
      expect(BoardGameGeek.configuration.parser).to be_a(FakeParser)
    end

    it "returns the proper Request object" do
      expect(BoardGameGeek.configuration.request_handler).to be_a(FakeRequestHandler)
    end
  end

  after :all do
    BoardGameGeek.reset
  end
end
