class AddIdnameIndexToUsers < ActiveRecord::Migration[5.2]
  def change
    add_index :users, :idname, unique: true
  end
end
