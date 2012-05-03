class Code < ActiveRecord::Base
  extend FriendlyId
  friendly_id :short, use: [:slugged, :history]

  
  def self.search( search, page )
    max_per_page = 20
    if search
      where( to_search( 'code',  search ) + ' OR ' + to_search( 'long',  search ) + ' OR ' + to_search( 'short',  search ) )
      .paginate( :per_page => max_per_page, :page => page, :order => 'code' )      
    else
      paginate( :per_page => max_per_page, :page => page, :order => 'code' )
    end
  end


  def self.to_search( field, search )
    tokens = search.split( /[,\s]+/ )
    n = tokens.length
    i = 0
    result = ''
    while i < n
      if i == 0
        result = field + " ILIKE '%" + tokens[i] + "%'"
      else
        result = result + " OR " + field + " ILIKE '%" + tokens[i] + "%'"
      end
      i = i + 1
    end 
    result
  end


end