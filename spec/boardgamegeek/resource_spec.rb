require "spec_helper"

module BoardGameGeek
  describe Resource do
    let(:resource_class) do
      if BoardGameGeek.const_defined? :ResourceImpl
        BoardGameGeek.send(:remove_const, :ResourceImpl)
      end

      class ResourceImpl
        extend Resource
      end

      ResourceImpl
    end

    describe "::resource_name" do
      it "defaults to the lowercase of the classname when extended" do
        expect(resource_class.resource_name).to eq("resourceimpl")
      end
    end

    describe "::resource_name=" do
      it "overrides the default resource name" do
        resource_name = "overriddenresource"
        resource_class.resource_name = resource_name
        expect(resource_class.resource_name).to eq(resource_name)
      end
    end

    describe "::request" do
      before :each do
        response_body = <<-EOL
          <items><item id="1"></item></items>
        EOL
        WebMock.stub_request(:get, %r(.*/resourceimpl)).to_return(:body => response_body)
      end

      it "yields the parsed return data" do
        expect{ |b| resource_class.request(:foo => "bar", &b) }.to yield_with_args(Hash)
      end

      it "returns the parsed return data" do
        expect(resource_class.request(:foo => "bar")).to be_a(Hash)
      end
    end
  end
end