class AddGroupIdToPost < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :group_id, :integer
  end
end
