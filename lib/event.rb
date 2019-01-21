# frozen_string_literal: true

require 'time'
require 'pry'
require_relative 'event_creator'

class Event
  attr_accessor :start_date, :length, :title, :attendees

  def initialize(
    start_date_time = omitted = Time.new,
    length_min_integer = omitted = 0,
    title_string = omitted = '', attendees_array = omitted = [], print_trigger = true
  )

    if !!!omitted # Création d'évenement avec au moins un paramètre
      case start_date_time
      when String
        @start_date = Time.parse(start_date_time)
      when Time
        @start_date = start_date_time
      else
        puts 'Echec - start_date doit être un objet String ou Time'
        return nil
      end
      @length = length_min_integer
      @title = title_string
      @attendees = attendees_array
      puts 'Evénement crée avec des inputs - ne mettre aucune input si tu veux le créer de manière intéractive.' if print_trigger
      to_s
    else # Aucun paramètre donné
      event_creation = EventCreator.new
      initialize(event_creation.event.start_date,
                 event_creation.event.length,
                 event_creation.event.title,
                 event_creation.event.attendees,
                 false)
    end
  end

  def postpone_24h
    @start_date += 24 * 60 * 60
    self
  end

  def end_date
    @start_date + @length * 60
  end

  def is_past
    end_date < Time.now
  end

  def is_future
    @start_date > Time.now
  end

  def is_soon
    is_future && ((@start_date - Time.now) < 30 * 60)
  end

  def to_s
    lines = []
    if @title && @length && @start_date && @attendees
      lines << (!@title.empty? ? "Titre : #{@title}" : 'Titre non défini')
      lines << "Date de début : #{@start_date.inspect}"
      lines << "Durée : #{@length} minutes"
      attendees.each do |attendee|
        lines << "Invité : #{attendee}"
      end
    else
      puts "Issue '@title && @length && @start_date && @attendees' is false"
    end
    lines.join("\n")
  end
end
