module BoardGameGeek
  module Result
    class BoardGame < ResultItem
      text_attribute :thumbnail
      text_attribute :image
      value_attribute :name
      text_attribute :description
      value_attribute :yearpublished, :type => :int, :name => :year_published
      value_attribute :minplayers, :type => :int, :name => :min_players
      value_attribute :maxplayers, :type => :int, :name => :max_players
      value_attribute :playingtime, :type => :int, :name => :playing_time
    end
  end
end
