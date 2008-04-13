MeritBadges = {
  "Monday & Tuesday (9:00 to 10:45)" => {
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

  "Monday & Tuesday (11:00 to 12:45)" => {
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

  "Thursday & Friday (9:00 to 10:45)" => {
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

  "Thursday & Friday (11:00 to 12:45)" => {
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

NullText = "(None)"

def index_from_entries
  ret = {}

  MeritBadges.keys.each_with_index do |slot,slot_index|
    subkey = {}
    MeritBadges[slot].keys.each_with_index do |item, index|
      subkey[index] = [slot, item]
    end
    ret[slot_index] = subkey
  end

  ret
end

MeritBadgeIndex = index_from_entries

class Camper < ActiveRecord::Base
  belongs_to :troop

  validates_presence_of :name
  validates_numericality_of :age, :greater_than => 0
  validates_numericality_of :rank, :greater_than => 0

  def merit_badge_slot_names
    MeritBadges.keys
  end

  def merit_badge_entries(slot)
    MeritBadges[slot].keys.unshift NullText
  end

  def meritbadge(x)
    return self.meritbadge1 if x == 0
    return self.meritbadge2 if x == 1
    return self.meritbadge3 if x == 2
    return self.meritbadge4 if x == 3
    return nil
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
