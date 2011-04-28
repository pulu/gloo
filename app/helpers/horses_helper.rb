module HorsesHelper
  
  # return the sire of the horse
  def sire
    sid = @horse.sire_id
    sid = (1..10).to_a.shuffle.first unless sid
    @sire = Horse.find(sid)
  end

  #return the dam of the horse
  def dam
    did = @horse.dam_id
    did = (1..10).to_a.shuffle.first unless did
    @dam = Horse.find(did)
  end

end
