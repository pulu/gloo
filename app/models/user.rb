# == Schema Information
# Schema version: 20110505233207
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  name               :string(255)
#  email              :string(255)
#  encrypted_password :string(255)
#  access             :integer         default(0)
#  language           :string          default('en')
#  salt               :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#

require 'digest'
class User < ActiveRecord::Base
  attr_accessor   :password
  attr_accessible :name, :email, :password, :password_confirmation, :language

  has_many :microposts, :dependent => :destroy
  has_many :horses
  has_many :players

  #-------------
  # Validations
  email_regex = /\A[\w+\_.]+@[a-z\d_.]+\.[a-z]+\z/i
  validates :name,  :presence   => true,
                    :length     => {:maximum => 64 }
  validates :email, :presence   => true,
                    :uniqueness => { :case_sensitive => false },
                    :format     => { :with => email_regex }
  # Automatically creates virtual attr 'password_confirmation'
  validates :password,  :presence => true,
                        :confirmation => true,
                        :length   => { :within => 6..40 }

  before_save :encrypt_password
  #--------------
  # methods

  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)  
  end
 
  def self.authenticate(email,submitted_password)
    user = find_by_email(email)
    return nil if user.nil?
    return user if user.has_password?(submitted_password)
  end
  
  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end

  def admin?
    access > 0 
  end

  def feed
    Micropost.where("user_id = ?", id )
  end
  
  private

    def encrypt_password
      self.salt = make_salt if new_record?
      self.encrypted_password = encrypt(password)
    end

    def encrypt(string)
      secure_hash("#{salt}--#{string}") 
    end

    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end

    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
  
end
