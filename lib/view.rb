require_relative 'controller'
require_relative 'store'
require 'colorize'

class View
  attr_accessor :author, :content, :params
  def create_item(author)
    print "Nom\n>"
    @name = gets.chomp
    print "Prix\n>"
    @price = gets.chomp
    print "Quantité\n>"
    @quantity = gets.chomp
    print "Marque\n>"
    @brand = gets.chomp
    print "Description\n>"
    @description = gets.chomp
    print "Couleur\n>"
    @color = gets.chomp

    if (@price.length < 1|| @name.length > 101 || @name.length < 1 || @description.length < 1 || @brand.length < 1 || @color.length < 1)
      p "Entrez des valeurs convenables"
      return (self.create_item)
    end

    puts "C'est un objet spécifique ? (y/n)"
    specific = gets.chomp == 'n' ? false : true
    @size = ""
    @type = ""
    if (specific)
      while (@type.length < 1)
        print "Valid types (shoe / poster / hard drive)\n>"
        @type = gets.chomp
      end
      while (@size.length < 1)
        print "Taille\n>"
        @size = gets.chomp
      end
    else 
      @type = 'other'
    end
    if (@type == "hard drive")
      @storage = ""
      while (@storage.length < 1)
        print "Storage\n>"
        @storage = gets.chomp
      end
    end

    @params = {id: Controller.new.all.length + 1, name: @name, price: @price, quantity: @quantity, brand: @brand, description: @description, size: @size, type: @type, color: @color, storage: @storage, author: author}
    return @params
  end

  def puts_items(array)
    array.each do |item|
      puts item
    end
  end
end