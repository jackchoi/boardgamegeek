require "spec_helper"

module BoardGameGeek
  module Result
    class ResultItem
      describe ItemAttribute do
        subject { ItemAttribute.new :@name => "image", :value => "5", :@children => ["some text value"] }

        context "#name" do
          its(:name) { is_expected.to eq("image") }
        end

        context "#text_value" do
          its(:text_value) { is_expected.to eq("some text value") }
        end

        context "#value" do
          its(:value) { is_expected.to eq("5") }
        end
      end
    end
  end
end
