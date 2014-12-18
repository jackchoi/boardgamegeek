module BoardGameGeek
  module Result
    class ResultItem
      attr_reader :id, :type

      def initialize(item_data)
        process_item_data(item_data)
      end
      
      def get_text_node_value(attribute)
        attribute[:@children].first.to_s
      end

      def get_node_value(attribute)
        attribute[:value]
      end

      private

      def process_item_data(item_data)
        set_basic_attributes(item_data)

        item_data[:@children].each do |attribute|
          invoke_attribute_callbacks(attribute)
        end
      end

      def set_basic_attributes(item_data)
        @id = item_data[:id].to_i
        @type = item_data[:type].to_sym
      end

      def invoke_attribute_callbacks(attribute)
        meth = "set_#{attribute[:@name]}"
        if self.respond_to? meth
          self.send meth, attribute
        end
      end
    end
  end
end
