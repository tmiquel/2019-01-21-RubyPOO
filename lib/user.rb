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
end
