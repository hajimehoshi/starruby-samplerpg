require "starruby"
require "sample_rpg/common_fonts"
require "sample_rpg/map_scene"
require "sample_rpg/window"

module SampleRPG
  class TitleScene

    include StarRuby

    def update(game)
      screen = game.screen
      command_window_x = (screen.width - command_window.width) / 2
      command_window_y = screen.height - command_window.height - 16
      10.times do |i|
        screen.clear
        screen.render_texture(title_texture, 0, 0)
        screen.render(command_window, command_window_x, command_window_y)
        alpha = (0xff * (10 - i).quo(10)).to_i
        screen.render_rect(0, 0, screen.width, screen.height, Color.new(0, 0, 0, alpha))      
        yield :continue
      end
      next_scene = loop do
        keys = Input.keys(:keyboard, :duration => 1)
        break nil if keys.include?(:escape)
        command_window.update
        if keys.include?(:enter)
          case command_window.index
          when 0
            break MapScene.new
          when 1
          when 2
            break nil
          end
        end
        screen.clear
        screen.render_texture(title_texture, 0, 0)
        screen.render(command_window, command_window_x, command_window_y)
        yield :continue
      end
      10.times do |i|
        screen.clear
        screen.render_texture(title_texture, 0, 0)
        screen.render(command_window, command_window_x, command_window_y)
        alpha = (0xff * (i + 1).quo(10)).to_i
        screen.render_rect(0, 0, screen.width, screen.height, Color.new(0, 0, 0, alpha))      
        yield :continue
      end
      yield :exit, next_scene
    end

    private

    def title_texture
      unless @title_texture
        @title_texture = Texture.new(320, 240)
        title = "Sample RPG"
        font = CommonFonts[12]
        tmp_texture = Texture.new(*font.get_size(title))
        tmp_texture.render_text(title, 0, 0, font, Color.new(0xff, 0xff, 0xff))
        x = (@title_texture.width - tmp_texture.width * 2) / 2
        y = 40
        @title_texture.render_texture(tmp_texture, x, y, :scale_x => 2, :scale_y => 2)
        tmp_texture.dispose
      end
      @title_texture
    end

    def command_window
      unless @command_window
        @command_window = Window.new(5 * 16, 4 * 16)
        @command_window.texts << "Start" << "Continue" << "Exit"
        @command_window.selectable = true
        @command_window.index = 0
      end
      @command_window
    end

  end
end
