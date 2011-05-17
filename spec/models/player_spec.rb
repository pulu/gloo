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
  
  #-------
  describe "micropost associations" do
    before(:each) do
      @attr = {:name => "Test user", :email => "spec_user@gmail.com",
                :password => "foobar", :password_confirmation => "foobar"}
      @user =  User.create(@attr)
      @player = Factory(:player)
      @general_post = Factory(:micropost)  
      @correct_post1 = Factory(:micropost, :user => @user, 
            :postable_type => "Player", :postable_id => @player.id )  
      @correct_post2 = Factory(:micropost, :user => @user, 
            :postable_type => "Player", :postable_id => @player.id )  
      @wrong_player_post = Factory(:micropost, :user => @user,   
            :postable_type => "Player", :postable_id => @player.id + 1 )  
      @horse_post = Factory(:micropost, :user => @user,  
            :postable_type => "Horse", :postable_id => @player.id )  
    end

    it "should include the posts about the player" do
      @player.microposts.include?(@correct_post1).should be_true
      @player.microposts.include?(@correct_post2).should be_true
    end
    it "should not include posts about a different player" do
      @player.microposts.include?(@wrong_player_post).should_not be_true
    end
    it "should not include posts about non-players" do
      @player.microposts.include?(@horse_post).should_not be_true
    end

  end

end
