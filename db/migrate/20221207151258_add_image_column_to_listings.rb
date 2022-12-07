class AddImageColumnToListings < ActiveRecord::Migration[6.1]
  def change
    add_column :listings, :image, :string
  end
end
