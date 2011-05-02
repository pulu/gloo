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

  validates :name,  :presence => true
  validates :email, :presence => true,
                    :uniqueness => true

  #----------------------
  def self.search(search)
 
    if search
      @horses = Horse.all(:conditions =>['name LIKE ?',"%#{search}%"])
      @players = Player.all(:conditions =>['name LIKE ?',"%#{search}%"])
    end

    @page = @horses + @players

  end

end
