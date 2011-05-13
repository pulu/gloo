class UsersController < ApplicationController
  before_filter :authenticate, :only => [:index, :edit, :update, :destroy]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user,   :only => :destroy

  # -----------
  def new
    @title = "Sign Up"
    @user = User.new
  end

  # -----------
  def index
    @title = "All Users"
    @users = User.all
  end

  # -----------
  def show
    @user = User.find(params[:id])
    if signed_in?
      @micropost = @user.microposts.new
      @feed_items = @user.feed.paginate( 
              :page => params[:page], :per_page => 10)
    end
    @title = @user.name
  end
  
  # -----------
  def create
    @user = User.new( params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome " + @user.name + "!"
      redirect_to @user
    else
      @title = "Sign Up"
      render 'new'
    end
  end

  # -----------
  def edit
    @title = "Edit Profile"
  end

  # -----------
  def update
    if @user.update_attributes( params[:user])
      flash[:success] = "Profile Updated."
      redirect_to @user
    else
      @title = "Edit Profile"
      render 'edit'
    end
  end

  # -----------------
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_path
  end

  #--------------------------------------------------
  private


  def correct_user
    @user = User.find(params[:id])
    redirect_to( root_path ) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end
end
