class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :name
      t.string :key
      t.text :lyrics
      t.text :note
      t.references :band, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
