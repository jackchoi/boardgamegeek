require 'forwardable'

module BoardGameGeek
  module Result
    class ResultSet
      include Enumerable
      extend ::Forwardable

      def_delegators :@items, :length, :each
      
      def initialize(items = [])
        @items = items
        @index = build_index

        self.freeze
      end
      
      def find(id)
        @index[id] ? @items[@index[id]] : nil
      end

      private

      def build_index
        index = {}

        @items.each_with_index do |item, idx|
          if item.respond_to? :id
            index[item.id] = idx
          end
        end

        index
      end
    end
  end
end
