module BoardGameGeek
  module Result
    class ItemAttribute
      def initialize(data)
        @data = data
      end

      def name
        @data[:@name]
      end

      def text_value
        @data[:@children].first.to_s
      end

      def method_missing(meth)
        if @data.key? meth.to_sym
          @data[meth.to_sym]
        end
      end
    end
  end
end
