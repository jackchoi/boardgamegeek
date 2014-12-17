require "spec_helper"

module BoardGameGeek
  module Result
    describe ResultSet do
      before :all do
        item = Struct.new(:id)

        items = 1.upto(3).map { |i| item.new(i) }

        @result_set = ResultSet.new(items)
      end

      context "#length" do
        it "returns the correct length" do
          expect(@result_set.length).to eq(3)
        end
      end

      context "#each" do
        it "yields to each item in the result" do
          expect{ |blk| @result_set.each(&blk) }.to yield_control.exactly(@result_set.length).times
        end
      end

      context "#find" do
        it "returns an items given an id" do
          item = @result_set.find(3)
          expect(item.id).to eq(3)
        end

        it "returns nil when id is not found" do
          expect(@result_set.find(9)).to be_nil
        end
      end
    end
  end
end
