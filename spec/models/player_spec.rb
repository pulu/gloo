require 'spec_helper'

describe Player do
  before( :each ) do
    @attr = {:name => "Test player", :email => "test@email.com", :user_id => 1} 
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

  it "should require an user_id" do
   no_id = @attr.merge( :user_id => "") 
   no_id_player = Player.create( no_id ) 
   no_id_player.should_not be_valid
  end

  it "should reject duplicate ids" do
  end

end
