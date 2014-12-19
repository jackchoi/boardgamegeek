require_relative "item_attribute"

module BoardGameGeek
  module Result
    class ResultItem
      attr_reader :id, :type

      def initialize(item_data)
        process_item_data(item_data)
      end

      class << self
        def text_attribute(name, opts = {})
          create_attribute(name, opts) { |attribute| attribute.text_value }
        end

        def value_attribute(name, opts = {})
          create_attribute(name, opts) { |attribute| attribute.value }
        end

        private

        def create_attribute(name, opts = {}, &blk)
          property_name = opts[:name] || name

          self.send :attr_reader, property_name
          self.send :define_method, "set_#{name}" do |attribute|
            property_value = blk.call(attribute)

            case opts[:type]
            when :int, :integer
              property_value = property_value.to_i
            end

            self.instance_variable_set("@#{property_name}", property_value)
          end
        end
      end

      private

      def process_item_data(item_data)
        set_basic_attributes(item_data)
        set_custom_attributes(item_data)
      end

      def set_basic_attributes(item_data)
        @id = item_data[:id].to_i
        @type = item_data[:type].to_sym
      end

      def set_custom_attributes(item_data)
        item_data[:@children].each do |attribute|
          set_custom_attribute ItemAttribute.new(attribute)
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
