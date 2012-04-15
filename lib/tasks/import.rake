require 'csv'

namespace :import do

  # rake import:codes[codes.csv]
  desc 'Import CSV file into the Codes Active Record table'
  task :codes, [:filename] => :environment do |task,args|
    puts( 'Listing tables...' )
    ActiveRecord::Base.connection.tables.each do |table|
      puts( table )
    end

    puts( 'Clear friendly_id_slugs table...')
    ActiveRecord::Base.connection.execute(
      'DELETE FROM friendly_id_slugs WHERE 1 = 1'
    )
    
    puts( 'Please wait while we create a lot of records...' )
    puts( 'Time for a coffee-break?' )
   
    firstline=0

    Code.delete_all()

    puts( 'Deleted existing records...' )
    puts( 'Starting bulk-import process...' )

    CSV.foreach( args[:filename], :col_sep => ',' ) do |row|

      if ( row == nil ) then
        next
      end

      if ( firstline == 0 ) then
        firstline=1
        next
      end

      params = {}

      # The keys are in ASCII but the data is in UTF-8.
      # Because we are importing CSV, the input file has $ instead of commas.
      params['code']  = row[0].gsub( /[$]/, ',' )
      params['long']  = row[1].gsub( /[$]/, ',' )
      params['short'] = row[2].gsub( /[$]/, ',' )

      Code.create( params )
    end
    
    puts( 'Done' )
  end

end