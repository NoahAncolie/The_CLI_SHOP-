require 'csv'
require_relative 'controller'
require_relative 'store'
require 'colorize'

class UserStore < Store

    def initialize
        @controller = Controller.new
        
    end

    private

    def navbar(item)
        while (true)
          puts "\n\n1.Montrer les items\n2.Choisir un autre Item\n3.Acheter cet item\n0.Quitter le service"
          params = gets.chomp.to_i
          
          case params
            when 1
              return (self.displayItems)
            when 2
                self.displayItems
                return (self.chooseId)
            when 3
                return (self.buyItem(item))
            when 0
              break
            else
              puts "Ce choix n'existe pas, merci de ressayer"
          end
        end
    end

    def buyItem(item)
        if (item[3].to_i <= 0)
            puts "Plus d'items dans la liste"
            return (self.navbar(item))
        end
        while(true)
            puts "\n#{item[1]} coûte #{item[2]} Combien voulez-vous en acheter ? (#{item[3]} en stock) "
            params = gets.chomp.to_i
            if (params <= 0 || params > item[3].to_i)
                puts "Entrez une quantité valide."
            else
                return (self.confirmBuy(item, params))
            end
        end
    end

    def confirmBuy(item, quantity)
        while(true)
            puts "\n#{item[1]} en #{quantity} exemplaires coûte $#{item[2].split('$')[1].to_f * quantity}. Procéder au payment ? (y/n)"
            params = gets.chomp
            if (params == "n")
                return (self.navbar(item))
            else
                puts "\nTrès bien, l'item à été acheté. Vous avez été débité sur votre compte de $#{item[2].split('$')[1].to_f * quantity}. À très bientôt !"
                self.modifyItemQty(item, quantity)
                return (self.navbar(item))
            end
        end
    end

    def modifyItemQty(item, quantity = 1)
        item_array = @controller.all 
        item_array[item[0].to_i - 1][3] = item_array[item[0].to_i - 1][3].to_i - quantity
        CSV.open('db/items.csv', 'w') do |csv|
        end
        i = 0;
        while (i < item_array.length - 1)
            item = item_array[i]
            File.open("db/items.csv", 'a+') { |f| f.write("#{item[0]},#{item[1]},#{item[2]},#{item[3]},#{item[4]},#{item[5]},#{item[6]},#{item[7]},#{item[8]},#{item[9]},#{item[10]},#{item[11]}\n")}
            i += 1
        end
        item = item_array[i]
        File.open("db/items.csv", 'a+') { |f| f.write("#{item[0]},#{item[1]},#{item[2]},#{item[3]},#{item[4]},#{item[5]},#{item[6]},#{item[7]},#{item[8]},#{item[9]},#{item[10]},#{item[11]}")}
    end
end

# Adrien Benaceur