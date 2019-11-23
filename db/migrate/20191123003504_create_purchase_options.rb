class CreatePurchaseOptions < ActiveRecord::Migration[6.0]
  def change
    create_table :purchase_options do |t|
      t.text :quality
      t.integer :price
      t.belongs_to :content, index: true, foreign_key: true, on_delete: :cascade
      t.timestamps
    end
  end
end
