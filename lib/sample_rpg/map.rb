module SampleRPG
  class Map

    include StarRuby

    attr_reader :width
    attr_reader :height

    def initialize(width, height)
      @width = width
      @height = height
      @tiles = Array.new(width * height)
    end

    def [](i, j)
      @tiles[i + j * width]
    end

    def []=(i, j, tile)
      @tiles[i + j * width] = tile
    end

    def on_rendered(texture, x, y)
      di = -((x + 15) / 16)
      dj = -((y + 15) / 16)
      dx = x % -16
      dy = y % -16
      (texture.height / 16 + 1).times do |j|
        (texture.width / 16 + 1).times do |i|
          tile_i = i + di
          tile_j = j + dj
          if 0 <= tile_i and tile_i < width and 0 <= tile_j and tile_j < height
            tile = self[tile_i, tile_j]
            if tile
              color = Color.new(0x33 * tile, 0x33 * tile, 0x33 * tile)
              render_x = i * 16 + dx
              render_y = j * 16 + dy
              texture.render_rect(render_x, render_y, 16, 16, color)
            end
          end
        end
      end
    end

  end
end
