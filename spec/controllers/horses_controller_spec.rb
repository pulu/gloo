require 'spec_helper'

describe HorsesController do
  render_views

  #------------
  describe "GET 'new'" do
    it "should be successful" do
      get :new
      response.should be_success
    end

    it "should have the right title" do
      get :new
      response.should have_selector("title", :content => "Horse") 
    end
  end

  # -------------
  describe "authentication of edit/update pages" do
    before(:each) do
      @horse =  Factory(:horse)
      @user =   Factory(:user)
    end

    describe "for non-signed-in users" do
      it "should deny access to edit" do
        get :edit, :id => @horse, :user => {}
        response.should redirect_to( signin_path )
      end
      it "should deny access to update" do
        put :update, :id => @horse, :user => {}
        response.should redirect_to( signin_path )
      end
    end

    describe "for signed-in non-owners " do
      before(:each) do
        @user = Factory(:user, :email => "a@b.com", :access => 0 )
        @horse = Factory(:horse, :name => "Test", :owner_id => @user.id + 1 )
        test_sign_in(@user)
      end
      it "should deny access to edit" do
        get :edit, :id => @horse, :user => @user 
        response.should redirect_to( root_path )
      end
      it "should deny access to update" do
        put :update, :id => @horse, :user => @user 
        response.should redirect_to( root_path )
      end
    end
  end
  
  #-----------------------
  describe "DELETE 'destroy' actions" do
    before(:each) do
      @horse = Factory(:horse) 
    end
    describe "for non admin users" do
      before(:each) do
        @user = Factory(:user)
        test_sign_in(@user)
      end
      it "should prevent access" do
        delete :destroy, :id => @horse 
        response.should redirect_to( horses_path) 
      end
    end
    describe "for admin users" do
      before(:each) do 
        admin = Factory(:user, :email => "su@foo.bar", :access => 1)
        test_sign_in(admin)
      end
      it "should delete horse" do
        lambda do
          delete :destroy, :id => @horse
        end.should change(Horse, :count).by(-1)
      end
      it "should redirect to horses page" do
        delete :destroy, :id => @horse 
        response.should redirect_to( horses_path )
      end
    end
  end
  #-

end

