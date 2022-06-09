require 'pry'
require 'csv'
require_relative 'controller'

class Item
  def initialize(keys, values)
    @item = values
  end

  def save
    items = Controller.new.all
    File.open("db/items.csv", 'a+') { |f| f.write("\n#{@item[0]},#{@item[1]},$#{@item[2]},#{@item[3]},#{@item[4]},#{@item[5]},#{@item[6]},#{@item[7]},#{@item[8]},#{@item[9]},#{@item[10]},#{@item[11]}")}
  end
end

