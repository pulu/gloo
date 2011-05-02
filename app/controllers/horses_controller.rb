class HorsesController < ApplicationController

  #--------------
  def show 
    @horse = Horse.find(params[:id]) 
    @title = @horse.name
  end

  #--------------
  def new
    @title = "Horses"

    @horse = Horse.new
    respond_to do |format|
      format.html
      format.json {render :json => @horse }
    end
  end

  #--------------
  def create 
    @title = "Create horse info"
    @horse = Horse.create(params[:horse])

    respond_to do |f|
      if @horse.save
        f.html { redirect_to( @horse, 
          :notice => 'Created horse info.')}
        f.json { render :json => @horse, :status => :created, :location => @horse }
      else 
        f.html { render :action => "new"}
        f.json { render :json => @horse.errors,
          :status => :unprocessable_entity}
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
    Horse.find( params[:id] ).destroy
    flash[:success] = "Horse Data Removed"
    redirect_to horses_path
  end

  #-------------------------------------------------------------------
  def search
    @horses = Horse.search parama[:searcs]
  end

end
