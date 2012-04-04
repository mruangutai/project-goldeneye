class CreateCodes < ActiveRecord::Migration
  def change
    create_table :codes do |t|
      t.string :code
      t.string :short
      t.string :long

      t.timestamps
    end
  end
end
