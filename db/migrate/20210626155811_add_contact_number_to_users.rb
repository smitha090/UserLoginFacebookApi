class AddContactNumberToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :contact_number, :integer
  end
end
