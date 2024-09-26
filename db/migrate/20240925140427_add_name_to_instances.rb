class AddNameToInstances < ActiveRecord::Migration[7.2]
  def change
    add_column :instances, :name, :string,  null: false
    add_index :instances, :name, unique: true
  end
end
