class RemoveContactNumberFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :contact_number, :integer
  end
end
