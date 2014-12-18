require_relative "result/result_set"
require_relative "result/result_item"

module BoardGameGeek
  module Result
    autoload :BoardGame, "boardgamegeek/result/board_game"
  end
end
