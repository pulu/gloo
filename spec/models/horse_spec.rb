require 'spec_helper'

describe Horse do
  before( :each ) do
    @attr = {:name => "Test horse", :owner_id => 1 } 
  end

  it "should create a valid instance given correct attribute values" do
    Horse.create!( @attr )
  end

  it "should require a name" do
   no_name = @attr.merge( :name => "") 
   no_name_horse = Horse.create( no_name ) 
   no_name_horse.should_not be_valid
  end

  it "should reject duplicate names" do
    Horse.create!( @attr )
    duplicate = Horse.new( @attr )
    duplicate.should_not be_valid
  end

end
