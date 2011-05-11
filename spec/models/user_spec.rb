require 'spec_helper'

describe User do

  before( :each ) do
    @attr = {
      :name => "Sample User",
      :email => "rspec@rspec.com",
      :password => "abcdefg",
      :password_confirmation => "abcdefg"
      }
  end

  it "should create a new instance if valid attributes" do
    User.create!( @attr )
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
    
    it "should require a password" do
      User.new( @attr.merge(:password => "", :password_confirmation => "")).
        should_not be_valid
    end
    it "should require a matching passwrod confirmation" do
      User.new( @attr.merge(:password_confirmation => "goo" )).
        should_not be_valid
    end
    it "should reject short passwords" do
      short = "a" * 5
      User.new(@attr.merge(:password => short, :password_confirmation => short)).
        should_not be_valid
    end
    it "should reject long passwords" do
      long = "a" * 41
      User.new(@attr.merge(:password => long, :password_confirmation => long)).
        should_not be_valid
    end
  end
  #---------
  describe "password encryptions" do
    before(:each) do
      @user = User.create!(@attr.merge(:email => "testemail@gmail.com"))
    end

    it "should have an encrypted password attribute" do
      @user.should respond_to( :encrypted_password )
    end
    it "should set the encrypted password" do
      @user.encrypted_password.should_not be_blank
    end

    #--------
    describe "has password? method" do
      it "should be true if the paswords match" do
        @user.has_password?( @attr[ :password ]).should be_true
      end
      it "should be false if the passwords do not match" do
        @user.has_password?( "invalid" ).should_not be_true
      end
    end

  end

  #----
  describe "privileged users" do

    before(:each) do
      @user = User.create(@attr)
    end

    it "should respond to admin" do
      @user.should respond_to(:access)
    end
    it "should not be priviledged by default" do
      @user.should_not be_admin
    end
    it "should be toggleable" do
      @user.toggle(:access)
      @user.should be_admin
    end
  end
  # --------------------------------------------------------------
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

end

