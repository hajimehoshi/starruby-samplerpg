require "starruby"
require "sample_rpg/map"

module SampleRPG
  class MapScene

    include StarRuby

    def initialize
      @map = Map.new(100, 100)
      @map.height.times do |j|
        @map.width.times do |i|
          @map[i, j] = rand(3)
        end
      end
    end

    def update(game)
      10.times do |i|
        screen = game.screen
        screen.clear
        screen.render(@map, -8, 0)
        alpha = (0xff * (10 - i).quo(10)).to_i
        screen.render_rect(0, 0, screen.width, screen.height, Color.new(0, 0, 0, alpha))      
        yield :continue
      end
      loop do
        screen = game.screen
        screen.clear
        screen.render(@map, -8, 0)
        yield :continue
      end
    end

  end
end
