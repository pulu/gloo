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

  describe "micropost" do
    
    before(:each) do
      @user = User.create( @attr )
      @mp1 = Factory(:micropost, :user => @user, :created_at => 1.day.ago)
      @mp2 = Factory(:micropost, :user => @user, :created_at => 1.hour.ago)
    end

    it "should have a microposts attribute" do
      @user.should respond_to( :microposts ) 
    end

    it "should have the microposts in the right order" do
      @user.microposts.should == [@mp2, @mp1]
    end

    it "should destroy associated microposts" do
      @user.destroy
      [@mp1,@mp2].each do |micropost|
        Micropost.find_by_id(micropost.id).should be_nil
      end
    end
  end

  describe "comment" do

    before(:each) do
      @user = User.create(@attr)
      @c1 = Factory(:comment, :user => @user, :created_at => 1.day.ago)
      @c2 = Factory(:comment, :user => @user, :created_at => 1.hour.ago)
    end

    it "should have a comment attribute" do
      @user.should respond_to( :comments ) 
    end

    it "should have the comments in the right order" do
      @user.comments.should == [@c2, @c1]
    end
      
    it "should destroy associated comments" do
      @user.destroy
      [@c1,@c2].each do |comment|
        Comment.find_by_id(comment.id).should be_nil
      end
    end
   end



end
