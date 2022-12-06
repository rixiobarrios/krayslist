class CreateListings < ActiveRecord::Migration[6.1]
  def change
    create_table :listings do |t|
      t.integer :seller_id
      t.integer :buyer_id
      t.string :title
      t.text :details
      t.integer :category_id

      t.timestamps
    end
  end
end
