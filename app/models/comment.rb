# == Schema Information
# Schema version: 20110503220618
#
# Table name: comments
#
#  id         :integer         not null, primary key
#  content    :string(255)
#  user_id    :integer
#  horse_id   :integer
#  created_at :datetime
#  updated_at :datetime
#

class Comment < ActiveRecord::Base
  attr_accessible :content, :horse_id

  belongs_to :user

  validates :content, :presence => true, :length => { :maximum => 140 }
  validates :user_id, :presence => true
  validates :horse_id,:presence => true

  default_scope :order => 'comments.created_at DESC'
end
