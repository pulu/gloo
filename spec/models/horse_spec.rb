require 'spec_helper'

describe Horse do
  before( :each ) do
    @attr = {:name => "Test horse", :user_id => 1 } 
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

  describe "micropost associations" do
    before(:each) do
      @attr = {:name => "Test user", :email => "spec_user@gmail.com",
                :password => "foobar", :password_confirmation => "foobar"}
      @user =  User.create(@attr)
      @horse = Factory(:horse)
      @general_post = Factory(:micropost)  
      @correct_post1 = Factory(:micropost, :user => @user, 
            :postable_type => "Horse", :postable_id => @horse.id )  
      @correct_post2 = Factory(:micropost, :user => @user, 
            :postable_type => "Horse", :postable_id => @horse.id )  
      @wrong_horse_post = Factory(:micropost, :user => @user,   
            :postable_type => "Horse", :postable_id => @horse.id + 1 )  
      @player_post = Factory(:micropost, :user => @user,  
            :postable_type => "Player", :postable_id => @horse.id )  
    end

    it "should include the posts about the horse" do
      @horse.microposts.include?(@correct_post1).should be_true
      @horse.microposts.include?(@correct_post2).should be_true
    end
    it "should not include posts about a different horse" do
      @horse.microposts.include?(@wrong_horse_post).should_not be_true
    end
    it "should not include posts about non-horses" do
      @horse.microposts.include?(@player_post).should_not be_true
    end

  end

end
