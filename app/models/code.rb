class Code < ActiveRecord::Base
  
  
  def self.search(search)
    if search
      find(:all, :conditions => [
        'code LIKE :search OR long LIKE :search OR short LIKE :search',
        {:search => "%#{search}%"}
      ])
    else
      find(:all)
    end
  end
  
  
end