class HorsesController < ApplicationController

  #--------------
  def show 
    @horse = Horse.find(params[:id]) 
    @title = @horse.name
  end

  #--------------
  def new
    @title = "Add Horse Profile"
    @horse = Horse.new
  end

  #--------------
  def create 
    @title = "Create Horse Info"
    @horse = Horse.create(params[:horse])

    respond_to do |f|
      if @horse.save
        redirect_to( @horse, :notice => 'Created horse info.')
      else 
        render :action => "new"
      end
    end
  end

  #--------------
  def index
    @title = "Horses"
    @horses = Horse.paginate(:page => params[:page])
  end

  #--------------
  def edit
    @title = "Edit Horse Info"
    @horse = Horse.find(params[:id])
  end

  #--------------
  def update
    @title = "Update Horse Info"
    @horse = Horse.find(params[:id])
    if @horse.update_attributes(params[:horse])
      flash[:success] = "Profile updated."
      redirect_to @horse 
    else 
      flash[:failure] = "Update failed"
      @title = "Edit Info"
      render 'edit'
    end
  end

  #--------------
  def destroy
    @title = "Delete Horse Info"
    Horse.find( params[:id] ).destroy
    flash[:success] = "Horse Data Removed"
    redirect_to horses_path
  end

  #-------------------------------------------------------------------
  def search
    @horses = Horse.search parama[:searcs]
  end

end
