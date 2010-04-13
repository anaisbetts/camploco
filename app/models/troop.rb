AvailableSessionsAsDate = {
  1 => Date.parse("2009-06-27"), 
  2 => Date.parse("2009-07-04"),
  3 => Date.parse("2009-07-11"), 
  4 => Date.parse("2009-07-18") 
}

AvailableSessionsAsText = {
  1 => "Week 1: June 27th - July 3rd",
  2 => "Week 2: July 4th - July 10th",
  3 => "Week 3: July 11th - July 17th",
  4 => "Week 4: July 18th - July 24th"
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
