require 'spec_helper'

describe Player do
  before( :each ) do
    @attr = {:name => "Test player", :email => "test@email.com" } 
  end

  it "should create a valid instance given correct attribute values" do
    Player.create!( @attr )
  end

  it "should require a name" do
   no_name = @attr.merge( :name => "") 
   no_name_player = Player.create( no_name ) 
   no_name_player.should_not be_valid
  end

  it "should reject too long names" do
  end

  it "should require an email" do
   no_email = @attr.merge( :email => "") 
   no_email_player = Player.create( no_email ) 
   no_email_player.should_not be_valid
  end

  it "should reject duplicate emails" do
    Player.create!( @attr )
    duplicate = Player.new( @attr )
    duplicate.should_not be_valid
  end

end
