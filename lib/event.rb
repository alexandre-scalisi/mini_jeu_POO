require 'time'
class Event
  attr_accessor :start_date
  
  def initialize(start_date,duration,title,mails)
    @start_date = Time.parse(start_date)
    @duration = duration
    @title = title
    @mails = mails
  end

  def postpone_24h
    start_date + (24*3600)
  end
end

event1 = Event.new("2019-01-13 09:00", 10, "standup quotidien", ["truc@machin.com", "bidule@chose.fr"])
event1.postpone_24h
puts event1.start_date
