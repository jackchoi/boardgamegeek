module BoardGameGeek
  class Result
    include Enumerable
    
    def initialize(items = [])
      @items = items
    end

    def each(&blk)
      @items.each do |item|
        yield item
      end
    end

    def method_missing(meth)
      @items.send meth
    end
  end
end
