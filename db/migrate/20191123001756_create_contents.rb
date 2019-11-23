class CreateContents < ActiveRecord::Migration[6.0]
  def change
    create_table :contents do |t|
      t.text :title
      t.text :plot
      t.integer :number
      t.text :type
      t.timestamps
    end
  end
end
