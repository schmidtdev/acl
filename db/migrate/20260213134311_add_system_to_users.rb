class AddSystemToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :system, :boolean, default: false, null: false
    add_index :users, :system
  end
end
