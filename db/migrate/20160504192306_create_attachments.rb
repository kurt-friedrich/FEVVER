class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.string :kind
      t.string :file_id
      t.references :song, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
