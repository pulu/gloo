# == Schema Information
# Schema version: 20110503220618
#
# Table name: horses
#
#  id                     :integer         not null, primary key
#  name                   :string(255)
#  breeder_id             :integer
#  sire_id                :integer
#  sire_bloodline         :string(255)
#  dam_id                 :integer
#  dam_bloodline          :string(255)
#  owner                  :string(255)
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

  has_many :comments, :dependent => :destroy

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

  #validation
  validates :name, :presence => true,
                   :uniqueness => true

end

