# == Schema Information
# Schema version: 20110426190831
#
# Table name: horses
#
#  id                     :integer         not null, primary key
#  name                   :string(255)
#  breeder_id             :integer
#  sire_id                :integer
#  dam_id                 :integer
#  owner                  :string(255)
#  foal_year              :integer
#  foal_country           :string(255)
#  color                  :string(255)
#  breed                  :string(255)
#  stallion               :boolean
#  vet_report_file_name   :string(255)
#  xray_file_name         :string(255)
#  dna_test_fname         :string(255)
#  registration_file_name :string(255)
#  photo_file_name        :string(255)
#  photo_content_type     :string(255)
#  photo_file_size        :integer
#  created_at             :datetime
#  updated_at             :datetime
#

class Horse < ActiveRecord::Base
  # Paperclip
  has_attached_file :photo,
    :styles => {
      :thumb => "40x32#",
      :small => "100x80",
      :medium => "400x320>"
     },
     :url => "/images/photos/:basename.:style.:extension",
     :path => ":rails_root/public/images/photos/:basename.:style.:extension"
  has_attached_file :vet_report
  has_attached_file :xray 
  has_attached_file :dna_test
  has_attached_file :registration
  # attr_protected :photo_file_name, :photo_content_type, :photo_size

  #validation
  validates :name, :presence => true,
                   :uniqueness => true

end
