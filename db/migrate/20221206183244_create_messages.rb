class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.integer :listing_id
      t.integer :sender_id
      t.integer :recipient_id
      t.string :body

      t.timestamps
    end
  end
end
