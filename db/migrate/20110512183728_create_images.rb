class CreateImages < ActiveRecord::Migration
  def self.up
    create_table :images do |t|
      t.string :name
      t.string :url

      t.references  :imageable, :polymorphic => true
      t.timestamps
    end
  end

  def self.down
    drop_table :images
  end
end
