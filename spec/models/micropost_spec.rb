require 'spec_helper'

describe Micropost do

  before( :each ) do

    @user = Factory(:user)
    @attr = {
      :content => "Value For content",
      :player_id => 1
    }
  end

  it "should create a new instance given valid attributes" do
    @user.microposts.create!(@attr)
  end

  describe "user associations" do
    before( :each ) do
      @micropost = @user.microposts.create(@attr)
    end

    it "should have an user attribute" do
      @micropost.should respond_to(:user)
    end
    it "should have the correct associated user" do
      @micropost.user_id.should == @user.id
      @micropost.user.should == @user
    end
  end

  describe "validations" do 
    it "should require an user_id" do
      Micropost.new(@attr).should_not be_valid
    end 
    it "should require a nonblank content" do
      @user.microposts.build(:content => "   ").should_not be_valid
    end
    it "should not have too long content" do
      @user.microposts.build(:content => "x" * 141).should_not be_valid
    end
    it "should require a player_id" do
      @user.microposts.build(:player_id => " ").should_not be_valid
    end
  end


end
