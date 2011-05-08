require 'spec_helper'

describe UsersController do
  render_views

  describe "GET 'show'" do
    before( :each ) do
      @user = Factory(:user)
    end

    it "should be successful" do
      get :show, :id => @user
      response.should be_success
    end
    it "should find the right user" do
      get :show, :id => @user
      assigns(:user).should == @user
    end
    it "should have the right title" do
      get :show, :id => @user
      response.should have_selector( 'title', :content => @user.name )
    end
    it "should include the user's name" do
      get :show, :id => @user
      response.should have_selector('h1', :content => @user.name )
    end
    it "should have a Gravatar" do
      get :show, :id => @user
      response.should have_selector("h1>img", :class => "gravatar")
    end
  end

  # ---------------------
  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
    it "should have the right title" do
      get 'new'
      response.should have_selector("title", :content => "Sign Up") 
    end
  end

  # ---------------------------
  describe "POST 'create'" do
    
    describe "Failure" do
      before(:each) do
        @attr = { :name => "", :email => "", :password => "",
                  :password_confirmation => "" }
      end

      it "should not create a user" do
        lambda do
          post :create, :user => @attr
        end.should_not change( User, :count)
      end
      it "should have the right title" do
        post :create, :user => @attr
        response.should have_selector( "title", :content => "Sign Up")
      end
      it "should renedr the 'new' page" do
        post :create, :user => @attr
        response.should render_template('new')
      end
    end
    
    describe "Success" do
      before(:each) do
        @attr = { :name => "Test User", :email => "test@gmail.com", 
                  :password => "foobar", :password_confirmation => "foobar" }
      end

      it "should create a user" do
        lambda do
          post :create, :user => @attr
        end.should change( User, :count).by(1)
      end
      it "should redirect to the right title page" do
        post :create, :user => @attr
        response.should redirect_to(user_path(assigns(:user)))
      end
      it "should have a welcome message" do
        post :create, :user => @attr
        flash[:success].should =~ /Welcome/i  
      end
    end 
  end
end

