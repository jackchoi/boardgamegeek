require "spec_helper"

describe "::parse" do
  let(:parser) { BoardGameGeek.parser }

  context "when content is empty" do
    it "returns an empty object" do
      content = ""
      expect(parser.parse(content)).to be_empty
    end
  end

  context "when content is malformed" do
    it "raises ParseError" do
      content = "<xml"
      expect{ parser.parse(content) }.to raise_error(BoardGameGeek::ParseError)
    end
  end

  context "when content is valid" do
    it "returns valid attributes" do
      content = %q|<items total="0" termsofuse="http://boardgamegeek.com/xmlapi/termsofuse"/>|
      output = parser.parse(content)

      expect(output.keys).to include(:@name, :@children, :total, :termsofuse)
    end

    it "returns valid child nodes" do
      content = <<-XML
        <items>
          <item type="test" id="4">
            <name value="test_name"/>
            <desc value="test_description"/>
          </item>
        </items>
        XML
      output = parser.parse(content)

      expect(output[:@children].count).to eq(1)
      expect(output[:@children].first.keys).to include(:@name, :@children, :type, :id)
    end

    it "parses text nodes properly" do
      content = <<-XML
        <items>
          <item type="node_type" id="1">
            <thumbnail>//www.example.com/thumb.jpg</thumbnail>
            <image>//www.example.com/image.jpg</image>
          </item>
        </items>
        XML
      output = parser.parse(content)

      thumbnail_node = output[:@children].first[:@children].first

      expect(thumbnail_node[:@children].first).to eq("//www.example.com/thumb.jpg")
    end

    it "does not return xml declaration header" do
      content = <<-XML
        <?xml version="1.0" encoding="utf-8"?>
        <items root="true"/>
        XML
      output = parser.parse(content)

      expect(output[:root]).to eq("true")
    end
  end
end
