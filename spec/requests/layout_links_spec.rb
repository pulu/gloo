require 'spec_helper'

describe "LayoutLinks" do

  it "should have a home page at '/'" do
    get '/'
    response.should have_selector('title', :content => "Home")
  end

  it "should have a contact page at '/contact'" do
    get '/contact'
    response.should have_selector('title', :content => "Contact")
  end

  it "should have a about page at '/about'" do
    get '/about'
    response.should have_selector('title', :content => "About")
  end

  it "should have a help page at '/help'" do
    get '/help'
    response.should have_selector('title', :content => "Help")
  end

  #----- user pages  
  it "should have a signup page at '/signup'" do
    get '/signup'
    response.should have_selector('title', :content => "Sign Up")
  end

  #------ horse pages 
  it "should have a horses page at '/horses'" do
    get '/horses'
    response.should have_selector('title', :content => "Horses")
  end
  #------ player pages 
  it "should have a players page at '/players'" do
    get '/players'
    response.should have_selector('title', :content => "Players")
  end
  #------ session info
  describe "when not signed in" do
   it "should have a signin link" do
      visit root_path
    response.should have_selector("a",  :href=> signin_path,
                                        :content => "SignIn")
   end
  end
  describe "when signed in" do
    before (:each) do
      @user = Factory(:user)
      visit signin_path
      fill_in :email,     :with => @user.email
      fill_in :password,  :with => @user.password
      click_button
    end

    it "should have a signout link" do
      visit root_path
      response.should have_selector("a",  :href => signout_path,
                                          :content => "SignOut")
    end
    it "should have a name linking to user's profile page" do
      visit root_path
      response.should have_selector("a",  :href => user_path(@user),
                                          :content => @user.name)
    end
  end


end
