class Code < ActiveRecord::Base
  extend FriendlyId
  friendly_id :short, use: [:slugged, :history]

  
  def self.search( search, page )
    max_per_page = 20
    if ( search and search.strip() != '' ) then
      where( to_search( 'code',  search ) + ' OR ' + to_search( 'long',  search ) + ' OR ' + to_search( 'short',  search ) )
      .paginate( :per_page => max_per_page, :page => page, :order => 'code' )      
    else
      paginate( :per_page => max_per_page, :page => page, :order => 'code' )
    end
  end


  def self.to_search( field, search )
    result = ''
    search.split( /[,\s]+/ ).each do |token|
      if ( token == nil ) then
        next
      end
      if ( result == nil or result.length == 0 ) then
        result = to_ilike( field, token )
      else
        result = result + " AND " + to_ilike( field, token )
      end
    end 
    '(' + result + ')'
  end


  def self.to_ilike( field, token )
    field + " ILIKE '%" + token.gsub(/[']/,"\'\'") + "%'"
  end


end