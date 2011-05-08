module HorsesHelper
  
  # return the sire of the horse
  def sire
    sid = @horse.sire_id
    @sire = Horse.find(sid) if sid
  end

  # return the dam of the horse
  def dam
    did = @horse.dam_id
    @dam = Horse.find( did ) if did
  end
  
  # search for horse name
  def search( search_phrase )
    search_condition = "%" + search_phrase + "%"
    Horse.find( :all, :conditions => ['name LIKE ?', search_condition ]) 
  end

  # get children from parent_ids
  def children
    id = @horse.id
    Horse.find( :all, :conditions => ['sire_id = ? OR dam_id = ?',id,id ])
  end

  # get grandchildren
  def grandchildren
    id = @horse.id
    children = Horse.all(:conditions => ['sire_id = ? OR dam_id = ?',id,id ])
    grandchildren = []
    children.each do |child|
      id = child.id
      grandchildren += Horse.all(:conditions => 
        ['sire_id = ? OR dam_id = ?', id, id ])
    end
    grandchildren.uniq
  end

end
