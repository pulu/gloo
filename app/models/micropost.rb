# == Schema Information
# Schema version: 20110503220618
#
# Table name: microposts
#
#  id         :integer         not null, primary key
#  content    :string(255)
#  user_id    :integer
#  player_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

class Micropost < ActiveRecord::Base
  attr_accessible :player_id, :content

  belongs_to :user

  validates :content, :presence => true, :length => { :maximum => 140 }
  validates :user_id, :presence => true
  validates :player_id, :presence => true

  default_scope :order => 'microposts.created_at DESC'
end
