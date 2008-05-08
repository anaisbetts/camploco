class ChangeRankToString < ActiveRecord::Migration
  def self.up
    remove_column :campers, :rank
    add_column :campers, :rank, :string
  end

  def self.down
    remove_column :campers, :rank
    add_column :campers, :rank, :int
  end
end
