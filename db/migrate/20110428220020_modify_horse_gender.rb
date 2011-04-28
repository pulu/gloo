class ModifyHorseGender < ActiveRecord::Migration
  def self.up
    remove_column :horses, :stallion
    add_column :horses, :gender, :string
  end

  def self.down
  end
end
