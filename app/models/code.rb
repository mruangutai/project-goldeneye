class Code < ActiveRecord::Base
  extend FriendlyId
  friendly_id :short, use: [:slugged, :history]

  
  def self.search(search, page)
    max_per_page = 20
    if search
      paginate :per_page => max_per_page, :page => page,
               :conditions => [
                  'code ILIKE :search OR long ILIKE :search OR short ILIKE :search',
                  {:search => "%#{search}%"}
                ],
               :order => 'code'
    else
      paginate :per_page => max_per_page, :page => page, :order => 'code'
    end
  end


end