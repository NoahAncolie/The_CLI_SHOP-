require_relative 'controller'
require_relative 'store'
require_relative 'userStore'
require_relative 'adminStore'
require 'pry'

class Router
  
  def initialize
    @controller = Controller.new
    @adminStore = AdminStore.new
    @userStore = UserStore.new
  end

  def perform
    while (true)
    puts "{{ {  {   { 🏠 | ACCUEIL | 🏠 }   }  } }}"
      puts "\nVous êtes ?"
      puts "1. Admin 🛡️"
      puts "2. User 👤"
      puts "0. Sortir 🚪🚶"
      params = gets.chomp.to_i
      
      case params
        when 1
          puts "Mot de passe : "
          password = gets.chomp
          if (password == "123123123")
            self.admin_interface
          else
            puts ("\n❌ Wrong Password ! ❌")
            self.perform
          end
        when 2
          self.user_interface
        when 0
          break
        else
          puts "Ce choix n'existe pas, merci de ressayer"
          return (self.perform)
      end
    end
  end

  private

  def user_interface
    while (true)
    puts "{{ {  {   { 🛒 | MAGASIN | 🛒 }   }  } }}"
      puts "1.Ajouter un Item\n2.Choisir un Item\n3.Afficher les items\n4.Afficher par ordre de prix croissant\n5.Afficher par ordre de prix décroissant\n6.Afficher par type\n7.Afficher les items du magasin\n8.Afficher les items des Users\n0.Revenir en arrière"
      params = gets.chomp.to_i
      
      case params
        when 1
          puts "==> Création de l'Item <=="
          puts "Entrez votre numéro de téléphone"
          phone = gets.chomp
          @controller.create_item(phone)
        when 2
          @userStore.chooseId
        when 3
          @userStore.displayItems
        when 4
          @userStore.sortItems(false, true, false, @controller.all)
          return (self.user_interface)
        when 5
          @userStore.sortItems(false, true, true, @controller.all)
          return (self.user_interface)
        when 6
          self.typeDisplayNav
          return (self.user_interface)
        when 7
          @userStore.displayItems("shop")
        when 8
          @userStore.displayItems("+33")
        when 0
          3.20
          break
        else
          puts "Choix indisponible"
      end
    end
  end

  def admin_interface
    puts "{{ {  {   { 📦 | INVENTAIRE DE MAGASIN | 📦 }   }  } }}"
      puts "\nque veux-tu faire ?"
      puts "1. Ajouter un Item"
      puts "2. Afficher tous les Items"
      puts "3. Afficher tous les Items par prix croissant"
      puts "4. Afficher tous les Items par prix décroissant"
      puts "5. Supprimer un Item"
      puts "0. Quitter le dashboard"
      params = gets.chomp.to_i
      
      case params
        when 1
          puts "==> Création de l'Item <=="
          @controller.create_item
          self.navbar_admin
        when 2
            @adminStore.displayItems
          self.navbar_admin
        when 3
            @adminStore.displayByPriceUp
            self.navbar_admin
        when 4
            @adminStore.displayByPriceDown
            self.navbar_admin
        when 5
            @adminStore.displayItems
            @adminStore.destroyItem
          self.navbar_admin
        when 0
          puts "A bientôt !"
        else
          puts "Ce choix n'existe pas, merci de ressayer"
          self.admin_interface
      end
  end

  def navbar_admin
    while (true)
      puts "1.Revenir Au Menu\n2.choisir un item\nX.Accueil"
      params = gets.chomp.to_i
      
      case params
        when 1
          return (self.admin_interface)
        when 2
          return (@adminStore.chooseId)
        else
          return (self.perform)
      end
    end
  end

  def typeDisplayNav
    while (true)
      puts "{{ {  {   { 📀 | TYPE | 📀 }   }  } }}"
      array_items = 0
        while (array_items == 0)
          puts "Quel type d'item lister ?\n1.Chaussures\n2.Posters\n3.Hard Drive"
          array_items = gets.chomp.to_i
        end
        array_items = array_items == 1 ? @controller.shoes : array_items == 2 ? @controller.posters : @controller.hard_drives
        puts "\n1.Afficher par taille croissante\n2.Afficher par taille décroissante\n3.Afficher par prix croissant\n4.Afficher par prix décroissant\n0.Revenir en arrière"
        params = gets.chomp.to_i
        
        case params
          when 1
            @userStore.sortItems(true, false, false, array_items)
            return (self.user_interface)
          when 2
            @userStore.sortItems(true, false, true, array_items)
            return (self.user_interface)
          when 3
            @userStore.sortItems(false, true, false, array_items)
            return (self.user_interface)
          when 4
            @userStore.sortItems(false, true, true, array_items)
            return (self.user_interface)
          when 0
            break
          else
            puts "Choix indisponible"
        end
      end
  end
end

