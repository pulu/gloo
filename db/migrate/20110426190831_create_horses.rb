class CreateHorses < ActiveRecord::Migration
  def self.up
    create_table :horses do |t|
      t.string  :name
      t.integer :breeder_id
      t.integer :sire_id
      t.integer :dam_id
      t.string  :owner
      t.integer :foal_year
      t.string  :foal_country
      t.string  :color
      t.string  :breed
      t.boolean :stallion
      t.string  :vet_report_file_name
      t.string  :xray_file_name
      t.string  :dna_test_file_name
      t.string  :registration_file_name
      t.string  :photo_file_name
      t.string  :photo_content_type
      t.integer :photo_file_size

      t.timestamps
    end
  end

  def self.down
    drop_table :horses
  end
end
