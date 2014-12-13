require "spec_helper"

module BoardGameGeek
  describe Configuration do
    let(:config) { Configuration.new }

    describe "#base_url" do
      it "can set a base_url" do
        config.base_url = "http://www.example.com"
        expect(config.base_url).to eq("http://www.example.com")
      end

      it %q(defaults base_url to "http://www.boardgamegeek.com/xmlapi2") do
        expect(config.base_url).to eq("http://www.boardgamegeek.com/xmlapi2")
      end
    end

    describe "#parser" do
      it "can set a parser to another object" do
        class FakeParser
        end
        fake_parser = FakeParser.new
        config.parser = fake_parser
        expect(config.parser).to be(fake_parser)
      end

      it "defaults parser to an instance of BoardGameGeek::Parser" do
        expect(config.parser).to be_a(BoardGameGeek::Parser)
      end
    end

    describe "#request_handler" do
      it "can set a requerst_handler to another object" do
        class FakeRequestHandler
        end
        fake_request_handler = FakeRequestHandler.new
        config.request_handler = fake_request_handler
        expect(config.request_handler).to be(fake_request_handler)
      end

      it "defaults request handler to an instance of BoardGameGeek::Request" do
        expect(config.request_handler).to be_a(BoardGameGeek::Request)
      end
    end
  end
end
