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
    Horse.all( :conditions => ['sire_id = ? OR dam_id = ?',id,id ])
  end

  # get grandchildren
  def grandchildren 
    id = @horse.id
    gen1 = children 
    grandchildren = []
    children.each do |child|
      id = child.id
      grandchildren += Horse.all(:conditions => 
        ['sire_id = ? OR dam_id = ?', id, id ])
    end
    grandchildren.uniq
  end

  # return subset of males (if male == false, females)
  def males(horses, male = true)
    females = []
    males = []
    horses.each do |horse|
      if horse.gender =~ /mare/i
        females.push horse 
      else 
        males.push horse
      end
    end
    male ? males : females  
  end
end
