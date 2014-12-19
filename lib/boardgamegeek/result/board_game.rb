module BoardGameGeek
  module Result
    class BoardGame < ResultItem
      text_attribute :thumbnail
      text_attribute :image
      text_attribute :description
      value_attribute :yearpublished, :type => :int, :name => :year_published
      value_attribute :minplayers, :type => :int, :name => :min_players
      value_attribute :maxplayers, :type => :int, :name => :max_players
      value_attribute :playingtime, :type => :int, :name => :playing_time
      value_attribute :minage, :type => :int, :name => :min_age

      attr_reader :name, :names

      collection_reader :categories, :mechanics, :families, :expansions,
                  :implementations, :designers, :artists, :publishers

      def set_name(attribute)
        if attribute.type == 'primary'
          @name = attribute.value
        end

        @names = [] if @names.nil?
        @names.push attribute.value
      end

      def set_link(attribute)
        collection_name = case attribute.type
                          when "boardgamecategory" then "categories"
                          when "boardgamemechanic" then "mechanics"
                          when "boardgamefamily" then "families"
                          when "boardgameexpansion"then "expansions"
                          when "boardgameimplementation" then "implementations"
                          when "boardgamedesigner" then "designers"
                          when "boardgameartist" then "artists"
                          when "boardgamepublisher"then "publishers"
                          end
                          
        collection = self.send collection_name unless collection_name.nil?
        unless collection.nil?
          collection[attribute.id.to_i] = attribute.value
        end
      end
    end
  end
end
