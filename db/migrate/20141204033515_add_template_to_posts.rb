class AddTemplateToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :template, :boolean, default: false
  end
end
