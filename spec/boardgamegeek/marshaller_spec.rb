require "spec_helper"

module BoardGameGeek
  describe Marshaller do
    let(:marshaller) { Marshaller.new }

    context "#define_item_association" do
      it "defines a class for an item type" do
        class Bar
        end

        marshaller.define_item_association :foo, Bar

        expect(marshaller.get_association(:foo)).to be(Bar)
      end
    end

    context "#define_default_association" do
      it "defines a default class an unknown item type" do
        class DefaultItem
        end

        marshaller.define_default_association DefaultItem

        expect(marshaller.get_association(:foo)).to be(DefaultItem)
      end

      it "defines a block to determine any unknown item types" do
        class Foo
        end
        class Bar
        end
        class Baz
        end

        marshaller.define_default_association do |item_type|
          case item_type
          when :foo then Foo
          when :bar then Bar
          else Baz
          end
        end

        expect(marshaller.get_association(:foo)).to be(Foo)
        expect(marshaller.get_association(:bar)).to be(Bar)
        expect(marshaller.get_association(:baz)).to be(Baz)
      end
    end

    context "#unmarshall" do
      create_new_struct = lambda do
        Struct.new(:item_data) do
          def id
            item_data[:id].to_i
          end

          def type
            item_data[:type].to_sym
          end
        end 
      end

      BoardGame = create_new_struct.call()
      BoardGameExpansion = create_new_struct.call()
      OtherItem = create_new_struct.call()

      def get_class_name(item_type)
        case item_type
        when :boardgame then BoardGame
        when :boardgameexpansion then BoardGameExpansion
        else OtherItem
        end
      end

      before :all do
        class SomeCollection < Array
        end

        @content = VCR.use_cassette "unmarshall_spec" do
          make_http_request "http://www.boardgamegeek.com/xmlapi2/thing?id=12493,95802,70722,162996"
        end

        marshaller = Marshaller.new(SomeCollection)
        marshaller.define_default_association do |item_type|
          get_class_name item_type
        end
        
        @unmarshalled_content = marshaller.unmarshall(@content)
      end

      subject { @unmarshalled_content }

      it { is_expected.to be_a(SomeCollection) }

      it "returns a Result with the right number of items" do
        expect(@unmarshalled_content.length).to eq(@content[:@children].length)
      end

      it "returns the proper unmarshalled objects in the result" do
        @unmarshalled_content.each do |unmarshalled_item|
          expected_class = get_class_name(unmarshalled_item.type)

          expect(unmarshalled_item).to be_a(expected_class)
        end
      end
    end
  end
end
