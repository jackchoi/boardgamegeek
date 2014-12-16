require "spec_helper"

module BoardGameGeek
  describe Result do
    let(:result) { Result.new [1, 2, 3] }

    context "#length" do
      it "returns the correct length" do
        expect(result.length).to eq(3)
      end
    end

    context "#each" do
      it "yields to each item in the result" do
        expect{ |blk| result.each(&blk) }.to yield_control.exactly(result.length).times
      end
    end
  end
end
