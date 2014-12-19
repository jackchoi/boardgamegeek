require "spec_helper"

module BoardGameGeek
  module Result
    class ResultItem
      describe ItemAttribute do
        subject do
          ItemAttribute.new :@name => "image",
                            :value => "5",
                            :type => "primary",
                            :@children => ["some text value"]
        end

        its(:name) { is_expected.to eq("image") }
        its(:text_value) { is_expected.to eq("some text value") }
        its(:value) { is_expected.to eq("5") }
        its(:type) { is_expected.to eq("primary") }
      end
    end
  end
end
