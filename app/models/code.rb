class Code < ActiveRecord::Base
  
  
  def self.search(search, page)
    max_per_page = 2
    if search
      paginate :per_page => max_per_page, :page => page,
               :conditions => [
                  'code LIKE :search OR long LIKE :search OR short LIKE :search',
                  {:search => "%#{search}%"}
                ],
               :order => 'code'
    else
      paginate :per_page => max_per_page, :page => page, :order => 'code'
    end
  end
  
  
end