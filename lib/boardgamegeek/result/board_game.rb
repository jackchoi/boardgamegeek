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
        @thumbnail = get_text_node_value(attribute)
      end

      def set_image(attribute)
        @image = get_text_node_value(attribute)
      end

      def set_name(attribute)
        @name = get_node_value(attribute).to_s
      end

      def set_description(attribute)
        @description = get_text_node_value(attribute)
      end

      def set_yearpublished(attribute)
        @year_published = get_node_value(attribute).to_i
      end

      def set_minplayers(attribute)
        @min_players = get_node_value(attribute).to_i
      end

      def set_maxplayers(attribute)
        @max_players = get_node_value(attribute).to_i
      end

      def set_playingtime(attribute)
        @playing_time = get_node_value(attribute).to_i
      end
    end
  end
end
