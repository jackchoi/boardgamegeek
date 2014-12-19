module BoardGameGeek
  class Marshaller
    def initialize(result_collection_class = Array)
      @item_type_classname_map = {}
      @default_item_lookup = nil
      @default_item_classname = nil
      @result_collection_class = result_collection_class
    end

    def unmarshall(content)
      items = unmarshall_items(content[:@children])

      @result_collection_class.new items
    end

    def define_default_association(classname = nil, &blk)
      if blk
        @default_item_lookup = blk
      end

      if classname
        @default_item_classname = classname
      end
    end

    def define_item_association(item_type, classname)
      @item_type_classname_map[item_type.to_sym] = classname
    end

    def get_association(item_type)
      key = item_type.to_sym

      if @item_type_classname_map[key].nil?
        unless @default_item_lookup.nil?
          new_class = @default_item_lookup.call(key)
        end

        if new_class.nil?
          new_class = @default_item_classname
        end

        @item_type_classname_map[key] = new_class
      end

      @item_type_classname_map[key]
    end

    private

    def unmarshall_items(items)
      items.inject([]) do |items, item|
        items.push unmarshall_item(item)
      end
    end

    def unmarshall_item(item)
      if item[:type]
        class_name = get_association(item[:type])
        class_name.new(item)
      end
    end
  end
end
