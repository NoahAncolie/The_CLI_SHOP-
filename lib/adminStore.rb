require 'csv'
require_relative 'controller'

class AdminStore < Store

    def initialize
        @controller = Controller.new
        
    end

    def destroyItem
        puts "Quel item ?"
        item_id = gets.chomp.to_i - 1
        i = 0
        item_array = @controller.all 
        item_array.delete_at(item_id)

        while (item_id < item_array.length)
            item_array[item_id][0] = item_id + 1
            item_id += 1
        end
        CSV.open('db/items.csv', 'w') do |csv|
        end
        item_array.each do |item|
            File.open("db/items.csv", 'a+') { |f| f.write("#{item[0]},#{item[1]},#{item[2]},#{item[3]},#{item[4]},#{item[5]},#{item[6]},#{item[7]},#{item[8]},#{item[9]}\n")}
        end
    end

    def editItem(item, value)
        item_array = @controller.all
        description = ""

        while (description.length <= 0)
            puts "Nouvelle valeure : "
            description = gets.chomp
        end
        if (value == 2)
            description = "$#{description}"
        end

        item_array[item[0].to_i - 1][value] = description

        CSV.open('db/items.csv', 'w') do |csv|
        end
        item_array.each do |item|
            File.open("db/items.csv", 'a+') { |f| f.write("#{item[0]},#{item[1]},#{item[2]},#{item[3]},#{item[4]},#{item[5]},#{item[6]},#{item[7]},#{item[8]},#{item[9]}\n")}
        end
        return (self.navbar(item))
    end

    private

    def navbar(item = nil)
        while (true)
          puts "\n1.Montrer les items\n2.Choisir un autre Item\n3.Éditer l'item\n0.Quitter le service"
          params = gets.chomp.to_i
          
          case params
            when 1
              return (self.displayItems)
            when 2
                self.displayItems
                return (self.chooseId)
            when 3
                puts "\n1.éditer la description\n2.éditer le prix\n3.éditer le nom\n4.éditer la marque\n5.éditer la couleur"
                if (item[7] != 'other')
                    puts "6.éditer la taille"
                end
                if (item[7] != 'hardware')
                    puts "7.éditer le storage"
                end
                params = gets.chomp.to_i
                while (true)
                    case params
                        when 1
                            return (self.editItem(item, 5))
                        when 2
                            return (self.editItem(item, 2))
                        when 3
                            return (self.editItem(item, 1))
                        when 4
                            return (self.editItem(item, 4))
                        when 5
                            return (self.editItem(item, 8))
                        when 6
                            if (item[7] != 'other')
                                return (self.editItem(item, 6))
                            else
                                puts "Ce choix n'existe pas, merci de ressayer"
                            end
                        when 7
                            if (item[7] == 'hardware')
                                return (self.editItem(item, 9))
                            else
                                puts "Ce choix n'existe pas, merci de reesayer"
                            end
                        else
                            puts "Ce choix n'existe pas, merci de ressayer"
                    end
                end
            when 0
              break
            else
              puts "Ce choix n'existe pas, merci de ressayer"
          end
        end
    end
end