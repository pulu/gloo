require 'spec_helper'

describe User do

  before( :each ) do
    @attr = {
      :name => "Sample User",
      :email => "foo@bar.com",
      :password => "abcdefg",
      :password_confirmation => "abcdefg"
      }
  end

  it "should create a new instance if valid attributes" do
    User.create( @attr )
  end

  it "should require a name" do
    no_name_user = User.new( @attr.merge(:name => ""))
    no_name_user.should_not be_valid
  end

  it "should reject names that are too long" do
    long_name_user = User.new( @attr.merge( :name => "x" * 65 ))
    long_name_user.should_not be_valid
  end

  it "should require an email" do
    no_email_user = User.new( @attr.merge(:email => ""))
    no_email_user.should_not be_valid
  end

  it "should reject duplicate emails" do
    upcasemail = @attr[ :email ].upcase
    User.create(@attr)
    duplicate = User.new( @attr.merge( :email => upcasemail ))
    duplicate.should_not be_valid
  end

  it "should accept valid emails" do
    addresses = %w{user@foo.com THE_UESR@foo.bar.org first.last@foo.jp}
    addresses.each do |address|
      valid_email_user = User.new(@attr.merge( :email => address ))
      valid_email_user.should be_valid
    end
  end

  it "should reject invalid emails" do
    addresses = %w{user@foo,com THE_UESR_at_foo.bar.org first.last@foo.}
    addresses.each do |address|
      valid_email_user = User.new(@attr.merge( :email => address ))
      valid_email_user.should_not be_valid
    end
  end

  #--------------
  describe "password validations" do

    before(:each) do
      @attr2 = {
       :name => "Sample User",
       :email => "foo@bar.goo.com",
       :password => "abcdefg",
       :password_confirmation => "abcdefg"
       }
     @user = User.create(@attr2)
    end
    it "should have an encrypted password attribute" do
      @user.should respond_to( :encrypted_password )
    end
  end
end
