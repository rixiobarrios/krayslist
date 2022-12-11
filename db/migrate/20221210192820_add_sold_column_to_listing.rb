class AddSoldColumnToListing < ActiveRecord::Migration[6.1]
  def change
    add_column :listings, :sold, :boolean, default: false, null: false
  end
end
