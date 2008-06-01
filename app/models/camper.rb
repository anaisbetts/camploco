MeritBadges = {
   0 => {
    "Archery" => [],
    "Astronomy" => [],
    "Aviation" => [],
    "Basketry" => [],
    "BSA Lifeguard" => [1,2,3],
    "Canoeing" => [],
    "COPE" => [1],
    "Emergency Prep" => [],
    "Leatherwork" => [],
    "Lifesaving" => [],
    "Nicoteh" => [1,2],
    "Pioneering" => [1],
    "Rifle" => [],
    "Small Boat Sailing" => [],
    "Swimming" => [],
    "System Management" => [2],
    "Wilderness Survival" => []
  }, 

  1 => {
    "Archery" => [],
    "Camping" => [],
    "Canoeing" => [],
    "Creature Studies" => [3],
    "Environmental Science" => [],
    "First Aid" => [3],
    "Leatherwork" => [],
    "Lifesaving" => [],
    "Photojournalism" => [],
    "Rowing" => [],
    "Shotgun" => [],
    "Swimming" => [],
    "Woodcarving" => []
  }, 

  2 => {
    "Archery" => [],
    "Basketry" => [],
    "Camping" => [],
    "Canoeing" => [],
    "Climbing" => [],
    "Cycling" => [],
    "Emergency Prep" => [],
    "Environmental Science" => [],
    "Indian Lore" => [],
    "Lifesaving" => [],
    "Orienteering" => [3],
    "Rifle" => [],
    "Rowing" => [],
    "Swimming" => []
  }, 

  3 => {
    "Archery" => [],
    "Canoeing" => [],
    "Environmental Science" => [],
    "Hiking and Backpacking" => [],
    "Lifesaving" => [],
    "Pottery" => [],
    "Shotgun" => [],
    "Small Boat Sailing" => [],
    "Space Exploration" => [],
    "Swimming" => [],
    "Woodcarving" => [],
  }, 

  4 => {
    "Waterskiing" => [],
    "Cooking" => [],
    "Forestry" => [],
    "Geology" => [],
    "Bird Study" => [],
    "Weather" => []
  }
}

MeritBadgeSessionNames = {
  0 => "Monday & Tuesday (9:00 to 10:45)",
  1 => "Monday & Tuesday (11:00 to 12:45)", 
  2 => "Thursday & Friday (9:00 to 10:45)", 
  3 => "Thursday & Friday (11:00 to 12:45)",
  4 => "Misc / Independent Study"
}

CamperRanks = [
  'Scout', 'Tenderfoot', '2nd Class', '1st Class', 'Star', 'Life', 'Eagle'
]

NoneText = "(None)"

class Camper < ActiveRecord::Base
  belongs_to :troop

  validates_presence_of :name
  validates_numericality_of :age, :greater_than => 0
  validates_presence_of :rank
  validates_numericality_of :troop_id, :greater_than => 0

  validates_each :meritbadge0, :meritbadge1, :meritbadge2, :meritbadge3, :meritbadge4 do |record, attr, value|
    i = nil
    throw "Attribute is invalid" unless (i = Camper.index_from_name(attr.to_s))
    
    if value and not record.slot_enabled?(i)
      record.errors.add "Session #{i+1} is already taken because of your selection on Session #{record.disabling_slot_number(i)+1} - "
    end

    record.errors.add "Session 1 isn't filled - " if i == 0 and not value
  end

  def self.merit_badge_slot_names
    (0..4).map {|x| MeritBadgeSessionNames[x]}
  end

  def self.merit_badge_entries(slot)
    [NoneText] + MeritBadges[slot].keys.sort
  end

  def self.index_from_name(name)
    # FIXME: This is ugly but I don't care
    return nil unless name =~ /^meritbadge[0-9]$/
    name[10] - '0'[0]
  end
  
  def current_disabled_list_for(slot)
    current_val = nil
    return [] unless (current_val = meritbadge(slot))

    MeritBadges[slot][current_val]
  end

  def disabling_slot_number(slot_number)
    return 0 if slot_number < 0
    return nil if slot_number == 0

    0.upto(slot_number-1) do |x|
      return x if current_disabled_list_for(x).include?(slot_number)
    end

    return nil
  end

  def slot_enabled?(slot_number)
    ret = (disabling_slot_number(slot_number) == nil)
    return ret
  end


  #
  # Boring code ahead
  #

  def meritbadge(x)
    # FIXME: There's _definitely_ a less retarded way to do this
    return self.meritbadge0 if x == 0
    return self.meritbadge1 if x == 1
    return self.meritbadge2 if x == 2
    return self.meritbadge3 if x == 3
    return self.meritbadge4 if x == 4
    return nil
  end


  def meritbadge_text(x)
    # FIXME: There's _definitely_ a less retarded way to do this
    return self.meritbadge0_text if x == 0
    return self.meritbadge1_text if x == 1
    return self.meritbadge2_text if x == 2
    return self.meritbadge3_text if x == 3
    return self.meritbadge4_text if x == 4
    return nil
  end

  # FIXME: There's probably a clever metaprogramming way to do this
  # Map nil <=> '(None)'

  def meritbadge0_text
    self.meritbadge0 || NoneText
  end

  def meritbadge1_text
    self.meritbadge1 || NoneText
  end

  def meritbadge2_text
    self.meritbadge2 || NoneText
  end

  def meritbadge3_text
    self.meritbadge3 || NoneText
  end

  def meritbadge4_text
    self.meritbadge4 || NoneText
  end

  def meritbadge0_text=(x)
    self.meritbadge0 = (x != NoneText ? x : nil)
  end

  def meritbadge1_text=(x)
    self.meritbadge1 = (x != NoneText ? x : nil)
  end

  def meritbadge2_text=(x)
    self.meritbadge2 = (x != NoneText ? x : nil)
  end

  def meritbadge3_text=(x)
    self.meritbadge3 = (x != NoneText ? x : nil)
  end

  def meritbadge4_text=(x)
    self.meritbadge4 = (x != NoneText ? x : nil)
  end

end
