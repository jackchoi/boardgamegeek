require_relative "item_attribute"
require_relative "attribute_definition"

module BoardGameGeek
  module Result
    class ResultItem
      extend AttributeDefinition

      attr_reader :id, :type

      def initialize(item_data)
        process_item_data(item_data)
      end

      private

      def process_item_data(item_data)
        set_basic_attributes(item_data)
        set_custom_attributes(item_data)
      end

      def set_basic_attributes(item_data)
        @id = item_data[:id].to_i if item_data[:id]
        @type = item_data[:type].to_sym if item_data[:type]
      end

      def set_custom_attributes(item_data)
        if item_data[:@children]
          item_data[:@children].each do |attribute|
            set_custom_attribute ItemAttribute.new(attribute)
          end
        end
      end 

      def set_custom_attribute(attribute)
        meth = "set_#{attribute.name}"
        if self.respond_to? meth
          self.send meth, attribute
        end
      end
    end
  end
end
