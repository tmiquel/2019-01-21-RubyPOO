# frozen_string_literal: true

require 'time'

class Event
  attr_accessor :start_date, :length, :title, :attendees

  def initialize(
    start_date_time = Time.new,
    length_min_integer = 0,
    title_string = '', attendees_array = []
  )

    case start_date_time
    when String
      @start_date = Time.parse(start_date_time)
    when Time
      @start_date = start_date_time
    else
      puts 'Failure - start_date shall be a String or a Time'
      return nil
    end

    @length = length_min_integer
    @title = title_string
    @attendees = attendees_array
  end

  def self.postpone_24h
    self.start_date = start_date + 24 * 60 * 60
    self
  end

  def self.end_date
    start_date + length * 60
  end

  def self.is_past
    end_date < Time.now
  end

  def self.is_future
    start_date > Time.now
  end

  def self.is_soon
    is_future && ((start_date - Time.now) < 30 * 60)
  end

  def self.to_s
    puts "Titre : #{title}"
    puts "Date de début : #{Time.parse(start_date)}"
    puts "Durée : #{length} minutes"
    puts "Invités : #{attendees.join(', ')}"
  end
end
