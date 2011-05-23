class MicropostsController < ApplicationController
  before_filter :authenticate,    :only => [:create, :destroy]
  before_filter :authorized_user, :only => :destroy

  # --------------
  def create
    @micropost = current_user.microposts.build(params[:micropost])
    if @micropost.save
      flash[:success] = t 'flash.micropost.created' 
    else
      @feed_items = []
    end
    redirect_to @micropost.object 
  end

  def destroy
    from = @micropost.object
    @micropost.destroy
    redirect_to from 
  end

  #-------------------
  private

    def authorized_user
      @micropost = Micropost.find( params[:id])
      redirect_to root_path unless current_user?(@micropost.user)
    end

end
