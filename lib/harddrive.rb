require_relative 'item'

class Poster < Item
    def initialize(keys, values)
      @item = values
    end
end

# Adrien Benaceur