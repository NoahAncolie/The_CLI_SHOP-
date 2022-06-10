require_relative 'item'

class Poster < Item
    def initialize(keys, values)
      @item = values
    end
  
    def save
      File.open("db/items.csv", 'a+') { |f| f.write("\n#{@item[0]},#{@item[1]},$#{@item[2]},#{@item[3]},#{@item[4]},#{@item[5]},#{@item[6]},#{@item[7]}")}
    end
end

# Adrien Benaceur