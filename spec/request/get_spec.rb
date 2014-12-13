require "spec_helper"

describe "::get" do
  let!(:request) { BoardGameGeek.request }

  subject(:response) do
    WebMock.stub_request(:any, /.*boardgamegeek.*/).to_return(:status => 200, :body => "test")

    request.get("test_uri", {:foo => "bar"})
  end

  it "returns a successful code" do
    expect(response[:code]).to be(200)
  end

  it "returns the proper body" do
    expect(response[:body]).to eq("test")
  end
end
