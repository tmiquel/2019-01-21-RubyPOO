# frozen_string_literal: true

require_relative '../lib/event'
require 'rspec/its'
require 'pry'

describe Event do
  before(:each) do
    Object.send(:remove_const, 'Event')
    load 'event.rb'
    @event = Event.new
    @my_event = Event.new(Time.now - 3600, 100, 'my event', ['Jean-Paul', 'Fanny'])
  end

  instance_methods_array =
    %i[postpone_24h end_date is_past is_future
       is_soon to_s]

  context 'created with defaults' do
    %i[length title attendees]
      .zip([0, '', []]).each do |attribute, default_value|
      its(attribute) { should eql(default_value) }
    end

    it 'should have a start_date at Time.now' do
      expect(@event.start_date.to_f).to be_within(1).of(Time.now.to_f)
    end
    # As @event is initialized slightly before being tested, be_within(10)
    # is used instead of .to_eq. 1 means 1 sec.

    it 'should have a Time object as start_date ' do
      expect(@event.start_date).to be_instance_of(Time)
    end

    instance_methods_array.each do |method|
      it "should respond to #{method}" do
        expect(@event).to respond_to(method)
      end
    end
  end

  context 'When I set actual values' do
    it 'should have the expected attributes' do
      expect(@my_event.start_date.to_f).to be_within(1).of((Time.now - 3600).to_f)
      expect(@my_event.length).to be_eql(100)
      expect(@my_event.title).to be_eql('my event')
      expect(@my_event.attendees).to be_eql(['Jean-Paul', 'Fanny'])
    end
    # j'aurais pu faire avec un its

    instance_methods_array.each do |method|
      it "should respond to #{method}" do
        expect(@my_event).to respond_to(method)
      end
    end
  end # fin de contexte
end
