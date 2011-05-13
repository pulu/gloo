require 'spec_helper'

describe MicropostsController do
  render_views

  describe "access control" do
    it "should deny access to create" do
      post :create
      response.should redirect_to(signin_path)
    end
    it "should deny access to destroy" do
      delete  :destroy, :id => 1
      response.should redirect_to(signin_path)
    end
  end
  
  #----
  describe "POST 'create'" do

    before(:each) do
      @user = test_sign_in( Factory(:user) )
    end

    describe "failure" do
      before(:each) do
        @attr = { :content => "", :category => 0, :about_id => 0 }
      end

      it "should not create a micropost" do
        lambda do
          post :create, :micropost => @attr
        end.should_not change(Micropost, :count)
      end
      it "should redirect to users profile page" do
        post :create, :micropost => @attr
        response.should redirect_to(user_path(@user))
      end
    end

    describe "success" do
      before(:each) do
        @attr = { :content => "Foo Bar post", :category => 0 }
      end
      it "should create post" do
        lambda do
          post :create, :micropost => @attr 
        end.should change(Micropost, :count).by(1)
      end
      it "should redirect to users profile page" do
          post :create, :micropost => @attr 
          response.should redirect_to( user_path( @user))
      end
      it "should flash a message" do
          post :create, :micropost => @attr 
          flash[:success].should =~ /blog post created/i
      end
    end

  end

end

