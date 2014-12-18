require "spec_helper"

module BoardGameGeek
  module Result
    describe BoardGame do
      context "::new" do
        before :all do
          payload = VCR.use_cassette "board_game_spec-new" do
            BoardGameGeek.api_handler.get :thing, :id => 12493
          end

          @board_game = BoardGame.new(payload[:@children].first)
        end

        context "basic properties" do
          subject { @board_game }

          its(:id) { is_expected.to eq(12493) }
          its(:type) { is_expected.to eq(:boardgame) }

          its(:thumbnail) { is_expected.to eq("//cf.geekdo-images.com/images/pic50404_t.jpg") }
          its(:image) { is_expected.to eq("//cf.geekdo-images.com/images/pic50404.jpg") }
          its(:name) { is_expected.to eq("Twilight Imperium (Third Edition)") }

          expected_description = <<-DESC
            Twilight Imperium Third Edition is an epic empire-building game of interstellar conflict, trade, and struggle for power. Players take the roles of ancient galactic civilizations, each seeking to seize the imperial throne via warfare, diplomacy, and technological progression. With geomorphic board tiles, exquisite plastic miniatures, hundreds of cards, and introducing a rich set of strategic dimensions that allows each player to refocus their game-plan, the original designer Christian T. Petersen has seamlessly incorporated the better qualities of other recently popular games to improve on the game-play of the original TI, making it at once perfectly well-rounded and pleasantly familiar to experienced gamers.&#10;&#10;TI3 is played by at least three players who belong to ten possible alien races, each with their own advantages and quirks. The 'designer notes' in the rulebook candidly and humbly acknowledge the inspiration for some of the improvements to the original game. The strategic game-play borrows the governing element from 'Puerto Rico' to involve players in an iteratively complex and yet fast-paced game experience with very little downtime. The game map, basic player progress and overall victory are dynamically determined in almost exactly the same way as they are by imaginative players of 'Settlers of Catan', while the &quot;Command&quot; system cleverly improves on the 'oil' logistical mechanism of 'Attack' to both manage turn-based activity and limit the size of armies, uniquely enabling weakened players to bounce back if they play their cards right.&#10;&#10;Part of the Twilight Imperium Series.&#10;&#10;Re-implements:&#10;&#10;    Twilight Imperium (second edition)&#10;&#10;&#10;&#10;&#10;Expanded by:&#10;&#10;    Twilight Imperium (Third Edition): Shattered Empire&#10;    Twilight Imperium (Third Edition): Shards of the Throne&#10;&#10;&#10;&#10;&#10;
          DESC
          its(:description) { is_expected.to eq(expected_description.strip) }
          its(:year_published) { is_expected.to eq(2005) }
          its(:min_players) { is_expected.to eq(3) }
          its(:max_players) { is_expected.to eq(6) }
          its(:playing_time) { is_expected.to eq(360) }
        end
      end
    end
  end
end
