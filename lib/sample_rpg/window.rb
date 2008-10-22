require "sample_rpg"
require "sample_rpg/common_fonts"

module SampleRPG
  class Window

    include StarRuby

    attr_reader :width
    attr_reader :height
    attr_accessor :index

    def initialize(width, height)
      @width = width
      @height = height
      @index = -1
      @selectable = false
    end

    def texts
      @texts ||= []
    end

    def selectable?
      @selectable
    end

    attr_writer :selectable 

    def update
      if selectable?
        keys = Input.keys(:keyboard, :duration => 1, :delay => 8, :interval => 1)
        if keys.include?(:down)
          self.index += 1
        elsif keys.include?(:up)
          self.index -= 1
        end
        self.index = [[index, 0].max, texts.size - 1].min
      end
    end

    def on_rendered(texture, x, y)
      texture.render_rect(x + 1, y + 1, width - 2, height - 2, Color.new(0x33, 0x33, 0x33, 0xee))
      font = CommonFonts[12]
      texts.each_with_index do |text, j|
        text_x = x + 8
        text_y = y + 8 + 16 * j + (16 - 12) / 2
        if index == j
          texture.render_rect(x + 4, y + 8 + 16 * j, width - 8, 16, Color.new(0x99, 0x99, 0x99, 0x99))
        end
        texture.render_text(text, text_x + 1, text_y + 1, font, Color.new(0x99, 0x99, 0x99, 0x99))
        texture.render_text(text, text_x, text_y, font, Color.new(0xff, 0xff, 0xff))
      end
    end

  end
end
