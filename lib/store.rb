require 'csv'
require_relative 'controller'

class Store

    def initialize
        @controller = Controller.new
        
    end

    def displayItems(from = "all")
        puts "==> Affichage des items <=="
        items_array = @controller.all.sort { |a,b| a[1] <=> b[1] }
        items_array.each do |item|
            if (from == "all")
                puts "#{item[0]}. #{item[1]}"
                if (item[7] == "hard drive")
                    puts "Storage #{item[9]}"
                end
                puts "\n"
            elsif (from == "shop" && item[10] == "shop")
                puts "#{item[0]}. #{item[1]}"
                if (item[7] == "hard drive")
                    puts "Storage #{item[9]}"
                end
                puts "\n"
            elsif (item[10] != "shop" && from != "shop")
                puts "#{item[0]}. #{item[1]}"
                if (item[7] == "hard drive")
                    puts "Storage #{item[9]}"
                end
                puts "\n"
            end
        end
    end

    def sortItems(bySize, byPrice, up, items_array)
        if (bySize && up)
            items_array = items_array.sort { |a,b| b[6] <=> a[6] }
        elsif (byPrice && up)
            items_array = items_array.sort { |a,b| b[2].split('$')[1].to_i <=> a[2].split('$')[1].to_i }
        elsif (byPrice && !up)
            items_array = items_array.sort { |a,b| a[2].split('$')[1].to_i <=> b[2].split('$')[1].to_i }
        elsif (bySize && !up)
            items_array = items_array.sort { |a,b| a[6] <=> b[6] }
        end
        items_array.each do |item|
            puts "#{item[0]}.#{item[1]}\nSize : #{item[6]}\nPrix : #{item[2]}"
            if (item[7] == "hard drive")
                puts "Storage #{item[9]}"
                puts "\n"
            end
        end
    end

    def chooseId
        while(true)
            puts "Quel item voulez-vous voir ?"
            params = gets.chomp.to_i - 1
            item = []
            if (params <= @controller.all.length)
                item = @controller.all[params]
                puts "\n💎 #{item[1]} 💎"
                puts"coût : #{item[2]}"
                puts"quantité : #{item[3].to_i <= 0 ? "Rupture de stock" : item[3]}"
                puts"marque : #{item[4]}"
                puts"description : #{item[5]}"
                if (item[7] != 'other')
                    puts "Taille : #{item[6]}"
                end
                if (item[7] == "hard drive")
                    puts "Storage #{item[9]}"
                end
                puts"color : #{item[8]}"
                return (self.navbar(item))
            else
                p "Choisissez un Item présent sur la liste"
            end
        end
    end
end