module BoardGameGeek
  module Result
    class ResultItem
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

        def value
          @data[:value]
        end
      end
    end
  end
end
