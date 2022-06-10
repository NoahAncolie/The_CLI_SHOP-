require_relative 'item'

class Shoe < Item
    def initialize(keys, values)
      @item = values
    end
end

# Adrien Benaceur