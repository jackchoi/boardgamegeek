require "spec_helper"

module BoardGameGeek
  describe API do
    describe "#get" do
      let!(:api) { BoardGameGeek.api_handler }

      context "when requesting a valid resource" do
        let(:valid_response) do
          VCR.use_cassette "api_get_spec-valid" do
            api.get "search", :query => "King of Tokyo", :exact => true
          end
        end

        it "returns properly parsed response" do
          expect(valid_response[:total]).to eq("1")
          expect(valid_response[:@children].count).to eq(1)
          expect(valid_response[:@children].first[:type]).to eq("boardgame")
        end
      end

      context "when requesting an invalid resource" do
        let(:invalid_response) do
          WebMock.stub_request(:get, /.*/).to_return(:status => 404)
          api.get "unknown"
        end

        it "raises InvalidResourceError" do
          expect{ invalid_response }.to raise_error(BoardGameGeek::InvalidResourceError)
        end
      end

      context "when request source is unable to respond" do
        let(:server_error_response) do
          WebMock.stub_request(:get, /.*/).to_return(:status => 504)
          api.get "anything"
        end

        it "raises APIError" do
          expect{ server_error_response }.to raise_error(BoardGameGeek::APIError)
        end
      end
    end
  end
end