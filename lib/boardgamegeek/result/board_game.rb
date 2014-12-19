module BoardGameGeek
  module Result
    class BoardGame < ResultItem
      attr_reader :thumbnail, :image, :name, :description, :year_published,
                  :min_players, :max_players, :playing_time,
                  :suggested_num_players, :suggested_player_age, :language_dependence,
                  :boardgame_category, :boardgame_mechanic,
                  :boardgame_family, :boardgame_expansion, :boardgame_implementation,
                  :boardgame_designer, :boardgame_artist, :boardgame_publisher

      def set_thumbnail(attribute)
        @thumbnail = attribute.text_value
      end

      def set_image(attribute)
        @image = attribute.text_value
      end

      def set_name(attribute)
        @name = attribute.value
      end

      def set_description(attribute)
        @description = attribute.text_value
      end

      def set_yearpublished(attribute)
        @year_published = attribute.value.to_i
      end

      def set_minplayers(attribute)
        @min_players = attribute.value.to_i
      end

      def set_maxplayers(attribute)
        @max_players = attribute.value.to_i
      end

      def set_playingtime(attribute)
        @playing_time = attribute.value.to_i
      end
    end
  end
end
