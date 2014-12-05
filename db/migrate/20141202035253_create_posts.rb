class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.text :content, null: false, limit: 16.megabytes - 1
      t.boolean :published, default: false
      t.references :user, index: true

      t.timestamps
    end
  end
end
