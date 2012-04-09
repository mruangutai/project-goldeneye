require 'csv'
require 'active_record'
require 'activerecord-import'

namespace :import do

  # rake import:codes[codes.csv]
  desc 'Import CSV file into the Codes Active Record table'
  task :codes, [:filename] => :environment do |task,args|
    puts( 'Please wait while we create a lot of records...' )
    puts( 'Time for a coffee-break?' )
    
    firstline=0
    keys = {}
    codes = []

    CSV.foreach( args[:filename], :col_sep => ',' ) do |row|

      if ( row == nil ) then
        next
      end

      if ( firstline == 0 ) then
        keys = row
        firstline=1
        next
      end

      params = {}

      # The keys are in ASCII but the data is in UTF-8.
      # Because we are importing CSV, the input file has $ instead of commas.
      params['code']  = row[0].gsub( /[$]/, ',' )
      params['long']  = row[1].gsub( /[$]/, ',' )
      params['short'] = row[2].gsub( /[$]/, ',' )

      codes << Code.new( params )
    end

    puts( 'Created new records...' )

    Code.delete_all()

    puts( 'Deleted existing records...' )
    puts( 'Starting bulk-import process...' )
    
    Code.import( codes )

    puts( 'Done' )
  end

end
