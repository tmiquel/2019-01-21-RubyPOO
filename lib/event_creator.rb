# frozen_string_literal: true

require_relative 'event'
require_relative 'user'

class EventCreator
  attr_accessor :event

  def set_event
    puts 'Salut, tu veux créer un événement ? Cool !'
    puts "Commençons, quel est le nom de l'événement ?"
    print '> '
    title = gets.chomp.to_s
    puts
    puts 'Super, quand aura-t-il lieu ? (format : AAAA-MM-JJ HH:MM)'
    print '> '
    start_date = Time.parse(gets.chomp.to_s)
    puts
    puts 'Au top, combien de temps en minutes va-t-il durer ?'
    print '> '
    length = gets.chomp.to_i
    puts
    puts 'Génial, qui va participer ? Balance leurs emails avec un ; entre chaque email'
    print '> '
    emails = gets.chomp.to_s.split(';').map(&:strip)
    attendees = EventCreator.get_users_by_emails(emails)
    puts
    puts "Super, c'est noté, à bientôt !"
    puts
    @event = Event.new(start_date, length, title, attendees, false)
    @event
  end

  def self.get_users_by_emails(emails_array)
    users_array = []
    emails_array.each do |email|
      user = User.find_by_email(email, print_trigger = false)
      user ||= User.new(email)
      users_array << user
    end
    users_array
  end

  def initialize
    @event = set_event
  end
end
