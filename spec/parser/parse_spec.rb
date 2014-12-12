require "spec_helper"

describe "::parse" do
  let(:parser) { BoardGameGeek.parser }

  context "when content is invalid" do
    it "returns an empty object" do
      content = ""
      expect(parser.parse(content)).to be_empty
    end
  end

  context "when content is valid" do
    it "returns valid attributes" do
      content = %q|<items total="0" termsofuse="http://boardgamegeek.com/xmlapi/termsofuse"/>|
      output = parser.parse(content)

      expect(output.keys).to include(:@name, :@children, :total, :termsofuse)
    end

    it "returns valid child nodes" do
      content = %q|
        <items>
          <item type="test" id="4">
            <name value="test_name"/>
            <desc value="test_description"/>
          </item>
        </items>|
      output = parser.parse(content)

      expect(output[:@children].count).to eq(1)
      expect(output[:@children].first.keys).to include(:@name, :@children, :type, :id)
    end
  end
end