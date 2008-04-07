AvailableWeeks = {
  Date.parse("2008-06-24") => "Week 1: June 24th - June 30th",
  Date.parse("2008-07-01") => "Week 1: July 1st - July 7th",
  Date.parse("2008-07-08") => "Week 1: July 8th - July 14th",
  Date.parse("2008-07-15") => "Week 1: July 15th - July 21th"
}

EmailRegex = /[A-Z0-9._%-]+@[A-Z0-9.-]+\.[A-Z]{2,4}/
ZipcodeRegex = /^\d{5}([\-]\d{4})?$/

class Troop < ActiveRecord::Base
  validates_presence_of :troopmaster
  validates_presence_of :troopmaster_address
  validates_presence_of :troopmaster_city
  validates_format_of :troopmaster_zipcode, :with => ZipcodeRegex
  validates_presence_of :troopmaster_email#, :with => EmailRegex
  validates_numericality_of :number, :greater_than => 0
  validates_presence_of :district
  validates_presence_of :council
end
