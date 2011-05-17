require 'spec_helper'

describe PlayersController do
  render_views

  # ------------
  describe "authentication of pages based on signin and ownership" do
    before(:each) do
      @player = Factory(:player)
      @user   = Factory(:user)
    end
  
    describe "for non-signed-in users" do
      it "should allow listing" do
        get :index 
        response.should be_success 
      end
      it "should deny access to creation" do
        get :new 
        response.should redirect_to( signin_path )
      end
      it "should deny access to edit" do
        get :edit, :id => @player, :user => {}
        response.should redirect_to( signin_path )
      end
      it "should deny access to update" do
        put :update, :id => @player, :user => {}
        response.should redirect_to( signin_path )
      end
    end

    describe "for signed-in non-owners " do
      before(:each) do
        test_sign_in(@user)
        @player.user_id += 1 if @player.user_id == @user.id 
      end
      it "allow creation" do
        get :new 
        response.should have_selector("title", :content => "Player") 
      end
      it "should deny access to edit" do
        get :edit, :id => @player, :user => @user 
        response.should redirect_to( root_path )
      end
      it "should deny access to update" do
        put :update, :id => @player, :user => @user 
        response.should redirect_to( root_path )
      end
    end

  end
  
  #-----------------------
  describe "DELETE 'destroy' actions" do
    before(:each) do
      @player = Factory(:player) 
    end
    describe "for non admin users" do
      before(:each) do
        @user = Factory(:user)
        test_sign_in(@user)
      end
      it "should prevent access" do
        delete :destroy, :id => @player 
        response.should redirect_to( players_path) 
      end
    end
    describe "for admin users" do
      before(:each) do 
        admin = Factory(:user, :email => "su@foo.bar", :access => 1)
        test_sign_in(admin)
      end
      it "should delete player" do
        lambda do
          delete :destroy, :id => @player
        end.should change(Player, :count).by(-1)
      end
      it "should redirect to player page" do
        delete :destroy, :id => @player 
        response.should redirect_to( players_path )
      end
    end
  end
  #-

end


