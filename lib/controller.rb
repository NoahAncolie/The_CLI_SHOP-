require_relative 'item'
require_relative 'view'
require 'colorize'
require 'csv'

class Controller

  def initialize
    @view = View.new
  end

  def create_item(author = "shop")
    params = @view.create_item(author)
    @item = Item.new(params.keys, params.values)
    @item.save
  end

  def all
    @all_items = Array.new
    CSV.open("db/items.csv").each do |ligne|
      @all_items << ligne
    end
    return (@all_items)
  end

  def shoes
      items_array = self.all.sort { |a,b| a[1] <=> b[1] }
      items_array = items_array.select { |a| a[7] == 'shoe' }
  end

  def hard_drives
    items_array = self.all.sort { |a,b| a[1] <=> b[1] }
    items_array = items_array.select { |a| a[7] == 'hard drive' }
  end

  def posters
    items_array = self.all.sort { |a,b| a[1] <=> b[1] }
    items_array = items_array.select { |a| a[7] == 'poster' }
  end
end
