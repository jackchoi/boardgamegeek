module BoardGameGeek
  module Result
    class BoardGame < ResultItem
      attr_reader :thumbnail, :image, :name, :description, :year_published,
                  :min_players, :max_players, :playing_time

      def set_thumbnail(attribute)
        @thumbnail = attribute[:@children].first.to_s
      end

      def set_image(attribute)
        @image = attribute[:@children].first.to_s
      end

      def set_name(attribute)
        @name = attribute[:value].to_s
      end

      def set_description(attribute)
        @description = attribute[:@children].first.to_s
      end

      def set_yearpublished(attribute)
        @year_published = attribute[:value].to_i
      end

      def set_minplayers(attribute)
        @min_players = attribute[:value].to_i
      end

      def set_maxplayers(attribute)
        @max_players = attribute[:value].to_i
      end

      def set_playingtime(attribute)
        @playing_time = attribute[:value].to_i
      end
    end
  end
end
