def horses
  @horses = Horse.all( :conditions => conditions )
end

private

def conditions 
  ["horses.name LIKE ?", "%#{keywords}%"] unless keywords.blank?
end
