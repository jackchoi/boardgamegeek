require "spec_helper"

module BoardGameGeek
  describe Request do
    describe "#get" do
      let!(:request) { BoardGameGeek.configuration.request_handler }
      let(:uri) { URI("http://www.example.com/") }

      subject(:response) do
        WebMock.stub_request(:any, "http://www.example.com").to_return(:status => 200, :body => "test")

        request.get(uri)
      end

      it "returns a successful code" do
        expect(response[:status_code]).to be(200)
      end

      it "returns the proper body" do
        expect(response[:body]).to eq("test")
      end
    end
  end
end
