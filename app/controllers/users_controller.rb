class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
    @title = @user.name
  end

  def new
    @title = "Sign Up"
    @user = User.new
  end

  def index
    @title = "Users"
    @users = User.all
  end

  def create
    @user = User.new( params[:user])
    if @user.save
      flash[:success] = "Welcome " + @user.name + "!"
      redirect_to @user
    else
      @title = "Sign Up"
      render 'new'
    end
  end

end
