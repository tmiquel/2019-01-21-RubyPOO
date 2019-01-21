# frozen_string_literal: true

class User
  attr_accessor :email, :name
  @@user_count = 0
  @@all_users_array = []

  def initialize(email_to_save, name_to_save = '')
    @email = email_to_save
    @name = name_to_save
    @@user_count += 1
    @@all_users_array << self
  end

  def self.count
    @@user_count
  end

  def self.all
    @@all_users_array
  end

  def self.find_by_email(email, print_trigger = true)
    all_users_email = @@all_users_array.collect(&:email)

    if all_users_email.index(email)
      return @@all_users_array[all_users_email.index(email)]
    else
      puts "Erreur - pas d'utilisateur avec l'email #{email} trouvé" if print_trigger
      return nil
    end
  end

  def to_s
    part_1 = "Email: #{@email}"
    part_2 = !@name.empty? ? "Nom: #{name}" : 'Nom indéfini'
    part_1 + ' - ' + part_2
  end
end
