module BoardGameGeek
  module Result
    module AttributeDefinition
      def text_attribute(name, opts = {})
        create_attribute(name, opts) { |attribute| attribute.text_value }
      end

      def value_attribute(name, opts = {})
        create_attribute(name, opts) { |attribute| attribute.value }
      end

      def collection_reader(*args)
        args.each do |property_name|
          self.send :define_method, property_name do
            var_name = "@#{property_name}"
            self.instance_variable_set var_name, {} unless self.instance_variable_defined? var_name
            self.instance_variable_get var_name
          end
        end
      end

      private

      def create_attribute(name, opts = {}, &blk)
        property_name = opts[:name] || name

        self.send :attr_reader, property_name
        self.send :define_method, "set_#{name}" do |attribute|
          property_value = blk.call(attribute)

          case opts[:type]
          when :int
            property_value = property_value.to_i
          end

          self.instance_variable_set("@#{property_name}", property_value)
        end
      end
    end
  end
end
