require "spec_helper"

module BoardGameGeek
  module Result
    describe BoardGame do
      context "::new" do
        before :all do
          payload = VCR.use_cassette "board_game_spec-new" do
            make_http_request "http://www.boardgamegeek.com/xmlapi2/thing?id=70323"
          end

          @board_game = BoardGame.new(payload[:@children].first)
        end

        subject { @board_game }

        context "basic properties" do
          its(:id) { is_expected.to eq(70323) }
          its(:type) { is_expected.to eq(:boardgame) }
        end

        context "image" do
          its(:thumbnail) { is_expected.to eq("//cf.geekdo-images.com/images/pic761434_t.jpg") }
          its(:image) { is_expected.to eq("//cf.geekdo-images.com/images/pic761434.jpg") }
        end

        context "names" do
          its(:name) { is_expected.to eq("King of Tokyo") }
          its(:names) do
            is_expected.to include "King of Tokyo", "King of Tokyo: La Furia dei Mostri",
              "Potwory w Tokio", "Regele din Tokyo", "Tokió Királya", "Vládce Tokia",
              "Ο Βασιλιάς Του Τόκυο", "Кралят на Токио", "Повелитель Токио",
              "キング・オブ・トーキョー", "東京之王"
          end
        end

        context "description" do
          expected_description = <<-DESC
            In King of Tokyo, you play mutant monsters, gigantic robots, and strange aliens &ndash; all of whom are destroying Tokyo and whacking each other in order to become the one and only King of Tokyo.&#10;&#10;At the start of each turn, you roll six dice. The dice show the following six symbols: 1, 2, or 3 Victory Points, Energy, Heal, and Attack. Over three successive throws, choose whether to keep or discard each die in order to win victory points, gain energy, restore health, or attack other players into understanding that Tokyo is YOUR territory.&#10;&#10;The fiercest player will occupy Tokyo, and earn extra victory points, but that player can't heal and must face all the other monsters alone!&#10;&#10;Top this off with special cards purchased with energy that have a permanent or temporary effect, such as the growing of a second head which grants you an additional die, body armor, nova death ray, and more.... and it's one of the most explosive games of the year!&#10;&#10;In order to win the game, one must either destroy Tokyo by accumulating 20 victory points, or be the only surviving monster once the fighting has ended.&#10;&#10;
          DESC
          its(:description) { is_expected.to eq(expected_description.strip) }
        end

        context "meta information" do
          its(:year_published) { is_expected.to eq(2011) }
          its(:min_players) { is_expected.to eq(2) }
          its(:max_players) { is_expected.to eq(6) }
          its(:playing_time) { is_expected.to eq(30) }
          its(:min_age) { is_expected.to eq(8) }
        end

        context "linked information" do
          its(:categories) do
            is_expected.to include 1017 => "Dice",
                                   1046 => "Fighting",
                                   1064 => "Movies / TV / Radio theme",
                                   1016 => "Science Fiction"
          end

          its(:mechanics) do
            is_expected.to include 2041 => "Card Drafting",
                                   2072 => "Dice Rolling",
                                   2685 => "Player Elimination"
          end
          its(:families) do
            is_expected.to include 9470 => "Asian Theme",
                                   18616 => "Cities: Tokyo",
                                   10634 => "Country: Japan",
                                   24569 => "Kaiju",
                                   5615 => "Monsters"
          end

          its(:expansions) do
            is_expected.to include 98833 => "King of Tokyo Promo Cards",
                                   132530 => "King of Tokyo: Garfield's Gift Promo Card",
                                   147183 => "King of Tokyo: Halloween",
                                   127067 => "King of Tokyo: Power Up!",
                                   154945 => "King of Tokyo: The Horde Promo Card"
          end

          its(:implementations) do
            is_expected.to include 160499 => "King of New York"
          end

          its(:designers) do
            is_expected.to include 14 => "Richard Garfield"
          end

          its(:artists) do
            is_expected.to include 48337 => "Benjamin Raynal"
          end

          its(:publishers) do
            is_expected.to include 6784 => "Bergsala Enigma",
                                   6194 => "Delta Vision Publishing",
                                   7496 => "Egmont Polska",
                                   22560 => "Fantasmagoria",
                                   15605 => "Galápagos Jogos",
                                   22650 => "GeGe Co Ltd",
                                   264 => "Heidelberger Spieleverlag",
                                   1391 => "Hobby Japan",
                                   18852 => "Hobby World",
                                   6275 => "HomoLudicus",
                                   8923 => "IELLO",
                                   6214 => "Kaissa Chess & Games",
                                   3218 => "Lautapelit.fi",
                                   25203 => "Lex Games",
                                   11107 => "Nordic Games",
                                   21053 => "REXhry",
                                   8313 => "Smart Ltd",
                                   17786 => "uplay.it edizioni",
                                   14078 => "Vennerød Forlag AS"
          end
        end
      end
    end
  end
end
