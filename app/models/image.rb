# == Schema Information
# Schema version: 20110512183728
#
# Table name: images
#
#  id             :integer         not null, primary key
#  name           :string(255)
#  url            :string(255)
#  imageable_id   :integer
#  imageable_type :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#

class Image < ActiveRecord::Base
  belongs_to  :imageable, :polymorphic => true
end
