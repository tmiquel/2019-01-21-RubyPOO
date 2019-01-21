# frozen_string_literal: true

class User
  attr_accessor :email, :name
  @@user_count = 0
  @@all_users_array = []

  def initialize(email_to_save)
    @email = email_to_save
    @@user_count += 1
    @@all_users_array << self
  end

  def self.count
    @@user_count
  end

  def self.all
    @@all_users_array
  end

  def self.find_by_email(email)
    all_users_email = @@all_users_array.collect do |user|
      user.email
    end

    if all_users_email.index(email) 
      return @@all_users_array[all_users_email.index(email)]
    else 
      puts "Error - no user with #{email} found"
      return nil
    end
  end

end
