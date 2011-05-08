# == Schema Information
# Schema version: 20110505233207
#
# Table name: players
#
#  id                 :integer         not null, primary key
#  name               :string(255)
#  email              :string(255)
#  user_id            :integer
#  team               :string(255)
#  handicap           :integer
#  best_result        :string(255)
#  age                :integer
#  tel                :string(255)
#  address            :string(255)
#  city               :string(255)
#  country            :string(255)
#  professional       :boolean
#  photo_file_name    :string(255)
#  photo_content_type :string(255)
#  photo_file_size    :integer
#  cv_file_name       :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#

class Player < ActiveRecord::Base

  # Paperclip
  has_attached_file :photo,
    :styles => {
      :thumb => "40x32#",
      :small => "100x80",
      :medium => "400x320>"
     },
     :url => "/images/photos/player/:basename.:style.:extension",
     :path => ":rails_root/public/images/photos/player/:basename.:style.:extension"
  has_attached_file :cv

  #-----------------------
  # validation
  validates :name,  :presence => true,
                    :length   => { :maximum => 64 }
  validates :user_id, :presence => true
  
  #----------------------------------------------------------------
  # search for player name
  def self.search( search )
    search_condition = "%" + search + "%"
    find( :all, :conditions => ['name LIKE ?', search_condition ]) 
  end
end
