# == Schema Information
# Schema version: 20110512183728
#
# Table name: microposts
#
#  id            :integer         not null, primary key
#  content       :string(255)
#  user_id       :integer
#  postable_id   :integer
#  postable_type :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#

class Micropost < ActiveRecord::Base
  attr_accessible :content, :postable_id, :postable_type

  belongs_to :user
  belongs_to :postable, :polymorphic => true

  validates :content, :presence => true, :length => { :maximum => 140 }
  validates :user_id, :presence => true

  default_scope :order => 'microposts.created_at DESC'

  # --------------------------------------------------
  def horse
    Horse.find( postable_id ) if postable_type == "Horse" and postable_id
  end

  def player 
    Player.find( postable_id ) if postable_type == "Player" and postable_id
  end

  def object
    horse || player || user 
  end

  def name
    object.name
  end
  
  def about 
    (postable_type && postable_id) ? postable_type.downcase + " " +name : nil
  end
end
