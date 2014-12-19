require "spec_helper"

module BoardGameGeek
  module Result
    describe ResultItem do
      class ResultItem
        text_attribute :text_field
        value_attribute :value_field
        value_attribute :numeric_value_field, :type => :int
        value_attribute :a_value_field, :name => :renamed_value_field
      end

      subject do
        attributes = []
        attributes.push :@name => :text_field, :@children => ["some_text_value"]
        attributes.push :@name => :value_field, :value => "some_value"
        attributes.push :@name => :numeric_value_field, :value => "256"
        attributes.push :@name => :a_value_field, :value => "a_value_field's value"

        ResultItem.new :@children => attributes
      end

      describe "::text_attribute" do
        its(:text_field) { is_expected.to eq("some_text_value") }
      end

      describe "::value_attribute" do
        its(:value_field) { is_expected.to eq("some_value") }
        its(:numeric_value_field) { is_expected.to eq(256) }
        its(:renamed_value_field) { is_expected.to eq("a_value_field's value") }
      end
    end
  end
end
