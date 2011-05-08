class CreateMicroposts < ActiveRecord::Migration
  def self.up
    create_table :microposts do |t|
      t.string :content
      t.integer :user_id
      t.integer :about_id

      t.timestamps
    end
    add_index :microposts, :user_id
    add_index :microposts, :about_id
  end

  def self.down
    drop_table :microposts
  end
end
