require "starruby"
require "sample_rpg/title_scene"

module StarRuby
  class Texture

    def render(object, *args)
      object.on_rendered(self, *args)
    end

  end
end

module SampleRPG

  module_function

  def main
    scenes = [SampleRPG::TitleScene.new]
    game = StarRuby::Game.new(320, 240, :title => "Sample RPG", :window_scale => 2)
    begin
      until scenes.empty?
        scenes.shift.update(game) do |state, arg|
          game.update_state
          break if game.window_closing?
          game.update_screen
          game.wait
          case state
          when :continue
          when :exit
            scenes.push(arg) if arg
            break 
          else
            raise ArgumentError, "invalid state"
          end
        end
      end
    ensure
      game.dispose
    end
  end

end
