# == Schema Information
# Schema version: 20110512183728
#
# Table name: horses
#
#  id                     :integer         not null, primary key
#  name                   :string(255)
#  user_id                :integer
#  breeder_id             :integer
#  sire_id                :integer
#  dam_id                 :integer
#  bloodline              :string(255)
#  foal_year              :integer
#  foal_country           :string(255)
#  color                  :string(255)
#  breed                  :string(255)
#  gender                 :string(255)
#  markings               :string(255)
#  vet_report_file_name   :string(255)
#  xray_file_name         :string(255)
#  dna_test_file_name     :string(255)
#  registration_file_name :string(255)
#  photo_file_name        :string(255)
#  photo_content_type     :string(255)
#  photo_file_size        :integer
#  created_at             :datetime
#  updated_at             :datetime
#

class Horse < ActiveRecord::Base
  belongs_to :user  
  has_many :microposts, :as => :postable 
  has_many :images,     :as => :imageable 

  validates :name,      :presence => true,
                        :uniqueness => true
  validates :user_id,  :presence => true

  # Paperclip
  has_attached_file :photo,
    :styles => {
      :thumb => "60x48#",
      :small => "150x120",
      :medium => "400x320>"
     },
     :url => "/images/photos/:basename.:style.:extension",
     :path => ":rails_root/public/docs/horse/:basename.:style.:extension"
  has_attached_file :vet_report,
     :url => "/docs/horse/:basename.:style.:extension",
     :path => ":rails_root/public/docs/horse/:basename.:style.:extension"
  has_attached_file :xray, 
     :url => "/docs/horse/:basename.:style.:extension",
     :path => ":rails_root/public/docs/horse/:basename.:style.:extension"
  has_attached_file :dna_test,
     :url => "/docs/horse/:basename.:style.:extension",
     :path => ":rails_root/public/docs/horse/:basename.:style.:extension"
  has_attached_file :registration,
     :url => "/docs/horse/:basename.:style.:extension",
     :path => ":rails_root/public/docs/horse/:basename.:style.:extension"

  #-----------------------------
  def self.search(search, page)
    paginate  :per_page => 10, :page => page,
              :conditions => ['name like ?', "%#{search}%"]
  end

end

