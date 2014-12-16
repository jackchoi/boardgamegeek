require "spec_helper"

module BoardGameGeek
  describe URIHelper do
    context "#resource_to_uri" do
      let(:uri_response) do
        URIHelper.new("http://www.example.com")
                 .resource_to_uri("sample_resource",
                                  :foo => "bar",
                                  :ids => [1, 2, 3])
      end

      it "returns a uri object" do
        expect(uri_response).to be_a(URI)
      end

      it "sets the right hostname in the returned object" do
        expect(uri_response.host).to eq("www.example.com")
      end

      it "sets the right path in the returned object" do
        expect(uri_response.path).to eq("/sample_resource")
      end

      it "sets the right query string" do
        expect(uri_response.query).to eq("foo=bar&ids=1,2,3")
      end
    end
  end
end
