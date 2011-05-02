# == Schema Information
# Schema version: 20110502010004
#
# Table name: players
#
#  id                 :integer         not null, primary key
#  name               :string(255)
#  email              :string(255)
#  nationality        :string(255)
#  handicap           :integer
#  best_result        :string(255)
#  current_team       :string(255)
#  age                :integer
#  professional       :boolean
#  photo_file_name    :string(255)
#  photo_content_type :string(255)
#  photo_file_size    :integer
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
  # attr_protected :photo_file_name, :photo_content_type, :photo_size


  #-----------------------
  # validation
  validates :name,  :presence => true,
                    :length   => { :maximum => 64 }
  validates :email, :presence => true,
                    :uniqueness => true
  
  #----------------------------------------------------------------
  # search for player name
  def self.search( search )
    search_condition = "%" + search + "%"
    find( :all, :conditions => ['name LIKE ?', search_condition ]) 
  end
end
