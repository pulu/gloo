require 'spec_helper'

describe User do
  
  before( :each ) do
    @attr = { :name => "Sample User", :email => "foo@goo.bar" }
  end

  it "should create a new instance if valid attributes" do
    User.create!(@attr)
  end

  it "should require a name" do
    no_name_user = User.new( @attr.merge(:name => ""))
    no_name_user.should_not be_valid
  end

  it "should require an email" do
    no_email_user = User.new( @attr.merge(:email => ""))
    no_email_user.should_not be_valid
  end

  it "should reject duplicate emails" do
    User.create!(@attr)
    duplicate = User.new(@attr)
    duplicate.should_not be_valid
  end

end
