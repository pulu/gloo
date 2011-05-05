# == Schema Information
# Schema version: 20110426190831
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
  attr_accessible :name, :email

  has_many :microposts, :dependent => :destroy
  has_many :comments,   :dependent => :destroy

  validates :name,  :presence => true
  validates :email, :presence => true,
                    :uniqueness => true


end
