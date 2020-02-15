class AddIdnameToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :idname, :string, null: false, default: ""
  end
end
