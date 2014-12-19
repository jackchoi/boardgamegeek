require "spec_helper"

module BoardGameGeek
  module Result
    describe AttributeDefinition do
      class TestClass
        extend AttributeDefinition

        text_attribute :text_field
        value_attribute :value_field
        value_attribute :numeric_value_field, :type => :int
        value_attribute :a_value_field, :name => :renamed_value_field
        collection_reader :collection_field
      end

      let(:test_object) { TestClass.new }

      describe "::text_attribute" do
        it "defines text node property reader" do
          test_object.set_text_field ItemAttribute.new(:@children => ["some_text_value"])

          expect(test_object.text_field).to eq("some_text_value")
        end
      end

      describe "::value_attribute" do
        it "defines value attribute property reader" do
          test_object.set_value_field ItemAttribute.new(:value => "some_value")

          expect(test_object.value_field).to eq("some_value")
        end

        it "defines the proper type for a value property" do
          test_object.set_numeric_value_field ItemAttribute.new(:value => "256")

          expect(test_object.numeric_value_field).to eq(256)
        end

        it "renames a field when a name is declared" do
          test_object.set_a_value_field ItemAttribute.new(:value => "a_value_field's value")

          expect(test_object.renamed_value_field).to eq("a_value_field's value")
        end
      end

      describe "::collection_reader" do
        it "defaults a reader to return a Hash" do
          expect(test_object.collection_field).to be_a(Hash)
        end
      end
    end
  end
end
