require "spec_helper"

module BoardGameGeek
  module Result
    describe ResultItem do
      context "::get_text_node_value" do
        let(:text_node_struct) do
          {:@name => "image", :@children => ["some text value"]}
        end

        subject { ResultItem::get_text_node_value(text_node_struct) }

        it { is_expected.to eq("some text value") }
      end

      context "::get_node_value" do
        let(:node_struct) do
          {:@name => "minplayers", :value => "5"}
        end

        subject { ResultItem::get_node_value(node_struct) }

        it { is_expected.to eq("5") }
      end
    end
  end
end
