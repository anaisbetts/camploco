AvailableSessionsAsDate = {
  1 => Date.parse("2008-06-24"), 
  2 => Date.parse("2008-07-01"),
  3 => Date.parse("2008-07-08"), 
  4 => Date.parse("2008-07-15") 
}

AvailableSessionsAsText = {
  1 => "Week 1: June 24th - June 30th",
  2 => "Week 2: July 1st - July 7th",
  3 => "Week 3: July 8th - July 14th",
  4 => "Week 4: July 15th - July 21th"
}

EmailRegex = /[A-Z0-9._%-]+@[A-Z0-9.-]+\.[A-Z]{2,4}/
ZipcodeRegex = /^\d{5}([\-]\d{4})?$/

class Troop < ActiveRecord::Base
  has_many :campers
  belongs_to :user

  validates_presence_of :troopmaster
  validates_presence_of :troopmaster_address
  validates_presence_of :troopmaster_city
  validates_presence_of :troopmaster_state
  validates_format_of :troopmaster_zipcode, :with => ZipcodeRegex
  validates_presence_of :troopmaster_email#, :with => EmailRegex
  validates_presence_of :number
  validates_presence_of :district
  validates_presence_of :council
  validates_presence_of :session

  def session_text=(v)
    ret = AvailableSessionsAsText.keys.find {|x| (AvailableSessionsAsText[x] == v) and x }
    self.session = ret
  end

  def session_text
    AvailableSessionsAsText[session]
  end

end
