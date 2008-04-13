MeritBadges = {
   0 => {
    "Archery" => [],
    "Astronomy" => [],
    "Aviation" => [],
    "Basketry" => [],
    "BSA Lifeguard" => [2,3,4],
    "Canoeing" => [],
    "COPE" => [2],
    "Emergency Prep" => [],
    "Leatherwork" => [],
    "Lifesaving" => [],
    "Nicoteh" => [2,3],
    "Pioneering" => [2],
    "Rifle" => [],
    "Small Boat Sailing" => [],
    "Swimming" => [],
    "System Management" => [3]
  }, 

  1 => {
    "Archery" => [],
    "Camping" => [],
    "Creature Studies" => [4],
    "Environmental Science" => [],
    "First Aid" => [4],
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
    "Orienteering" => [4],
    "Rifle" => [],
    "Rowing" => [],
    "Swimming" => []
  }, 

  3 => {
    "Archery" => [],
    "Canoeing" => [],
    "Hiking and Backpacking" => [],
    "Lifesaving" => [],
    "Pottery" => [],
    "Shotgun" => [],
    "Small Boat Sailing" => [],
    "Space Exploration" => [],
    "Swimming" => [],
    "Woodcarving" => [],
  }
}

MeritBadgeSessionNames = {
  0 => "Monday & Tuesday (9:00 to 10:45)",
  1 => "Monday & Tuesday (11:00 to 12:45)", 
  2 => "Thursday & Friday (9:00 to 10:45)", 
  3 => "Thursday & Friday (11:00 to 12:45)"
}

class Camper < ActiveRecord::Base
  belongs_to :troop

  validates_presence_of :name
  validates_numericality_of :age, :greater_than => 0
  validates_numericality_of :rank, :greater_than => 0

  def self.merit_badge_slot_names
    (0..3).map {|x| MeritBadgeSessionNames[x]}
  end

  def self.merit_badge_entries(slot)
    MeritBadges[slot].keys.sort
  end

  def meritbadge(x)
    return self.meritbadge1 if x == 0
    return self.meritbadge2 if x == 1
    return self.meritbadge3 if x == 2
    return self.meritbadge4 if x == 3
    return nil
  end

  def meritbadge1_text
  end

  def meritbadge2_text
  end

  def meritbadge3_text
  end

  def meritbadge4_text
  end

  def meritbadge1_text=(x)
  end

  def meritbadge2_text=(x)
  end

  def meritbadge3_text=(x)
  end

  def meritbadge4_text=(x)
  end
  
  def current_disabled_list_for(slot)
    return [] unless (current_val = meritbadge(slot))

    slot_name, item_name = MeritBadgeIndex[slot][current_val]
    MeritBadges[slot_name][item_name]
  end

  def slot_enabled?(slot_number)
    return false if slot_number < 0
    return true if slot_number == 0

    0.upto(slot_number-1) do |x|
      next unless meritbadge(x)
      return false if current_disabled_list_for(x).include? slot_number
    end

    true
  end
end
