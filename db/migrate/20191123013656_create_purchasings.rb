class CreatePurchasings < ActiveRecord::Migration[6.0]
  def change
    create_table :purchasings do |t|
      t.belongs_to :purchase_option, null: false, foreign_key: true, on_delete: :cascade
      t.belongs_to :content, null: false, foreign_key: true, on_delete: :cascade
      t.belongs_to :user, null: false, foreign_key: true, on_delete: :cascade, index: true
      t.timestamp :expires_at
      t.timestamps
    end
  end
end
