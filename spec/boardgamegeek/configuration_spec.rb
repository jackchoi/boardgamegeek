require "spec_helper"

shared_examples "a string configuration setting" do
  it "can set a setting to a new value" do
    config.send "#{setting_name}=", new_setting
    expect(config.send(setting_name)).to eq(new_setting)
  end

  it "defaults the setting to a proper value" do
    expect(config.send(setting_name)).to eq(default_setting)
  end
end

shared_examples "an object configuration setting" do
  it "can set a setting to a new object" do
    config.send "#{setting_name}=", new_setting
    expect(config.send(setting_name)).to be(new_setting)
  end

  it "defaults the setting to the proper class" do
    expect(config.send(setting_name)).to be_a(default_setting)
  end
end

module BoardGameGeek
  describe Configuration do
    let(:config) { Configuration.new }

    describe "#base_url" do
      it_behaves_like "a string configuration setting" do
        let(:setting_name) { "base_url" }
        let(:new_setting) { "http://www.example.com" }
        let(:default_setting) { "http://www.boardgamegeek.com/xmlapi2" }
      end
    end

    describe "#parser" do
      class FakeParser
      end

      it_behaves_like "an object configuration setting" do
        let(:setting_name) { "parser" }
        let(:new_setting) { FakeParser }
        let(:default_setting) { Parser }
      end
    end

    describe "#request_handler" do
      class FakeRequestHandler
      end

      it_behaves_like "an object configuration setting" do
        let(:setting_name) { "request_handler" }
        let(:new_setting) { FakeRequestHandler }
        let(:default_setting) { Request }
      end
    end
  end
end
