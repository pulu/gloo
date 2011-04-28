module HorsesHelper
  
  # return the sire of the horse
  def sire
    @sire = Horse.find(@horse.sire_id)
  end

  #return the dam of the horse
  def dam
    @dam = Horse.find(@horse.dam_id)
  end

end
