class AddSlugToCodes < ActiveRecord::Migration
  def change
    add_column :codes, :slug, :string
    add_index :codes, :slug, unique: true
  end
end
