class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
    @title = @user.name
  end

  def new
    @title = "Sign Up"
  end

  def index
    @title = "Users"
    @users = User.all
  end

end
