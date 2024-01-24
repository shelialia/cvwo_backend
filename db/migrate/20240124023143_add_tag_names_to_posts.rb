class AddTagNamesToPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :tag_names, :string
  end
end
