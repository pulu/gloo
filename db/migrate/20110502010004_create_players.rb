class CreatePlayers < ActiveRecord::Migration
  def self.up
    create_table :players do |t|
      t.string  :name
      t.string  :email
      t.string  :team
      t.integer :handicap
      t.string  :best_result
      t.integer :age
      t.string  :tel
      t.string  :address
      t.string  :country
      t.boolean :professional
      t.string  :photo_file_name
      t.string  :photo_content_type
      t.integer :photo_file_size

      t.timestamps
    end
  end

  def self.down
    drop_table :players
  end
end