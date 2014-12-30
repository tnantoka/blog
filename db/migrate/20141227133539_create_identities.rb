class CreateIdentities < ActiveRecord::Migration
  def change
    create_table :identities do |t|
      t.string :uid, null: false
      t.string :provider, null: false
      t.string :nickname, null: false
      t.string :url, null: false
      t.text :raw_info, null: false

      t.timestamps
    end
  end
end
