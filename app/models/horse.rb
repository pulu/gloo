class Horse < ActiveRecord::Base

  has_many :comments, :dependent => :destroy

  # Paperclip
  has_attached_file :photo,
    :styles => {
      :thumb => "60x48#",
      :small => "150x120",
      :medium => "400x320>"
     },
     :url => "/images/photos/:basename.:style.:extension",
     :path => ":rails_root/public/images/photos/:basename.:style.:extension"
  has_attached_file :vet_report
  has_attached_file :xray 
  has_attached_file :dna_test
  has_attached_file :registration

  #validation
  validates :name,      :presence => true,
                        :uniqueness => true
  validates :owner_id,  :presence => true

end

