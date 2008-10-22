require "starruby"

module SampleRPG
  module CommonFonts

    include StarRuby

    module_function

    def [](size)
      (@fonts ||= Hash.new do |hash, key|
         hash[key] = Font.new(File.join(File.dirname(__FILE__), "../fonts/bdfmplus.ttf"), key)
       end)[size]
    end

  end
end
