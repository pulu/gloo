class CreateHorses < ActiveRecord::Migration
  def self.up
    create_table :horses do |t|
      t.string  :name
      t.integer :owner_id
      t.integer :breeder_id
      t.integer :sire_id
      t.integer :dam_id
      t.string  :bloodline
      t.integer :foal_year
      t.string  :foal_country
      t.string  :color
      t.string  :breed
      t.string  :gender
      t.string  :markings
      t.string  :vet_report_file_name
      t.string  :xray_file_name
      t.string  :dna_test_file_name
      t.string  :registration_file_name
      t.string  :photo_file_name
      t.string  :photo_content_type
      t.integer :photo_file_size

      t.timestamps
    end
    add_index :horses, :name
    add_index :horses, :owner_id
  end

  def self.down
    drop_table :horses
  end
end
