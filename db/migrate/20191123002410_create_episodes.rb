class CreateEpisodes < ActiveRecord::Migration[6.0]
  def change
    create_table :episodes do |t|
      t.text :title
      t.text :plot
      t.integer :number
      t.integer :season_id, index: true, null: false
      t.timestamps
    end

    add_foreign_key :episodes, :contents, column: :season_id
  end
end
