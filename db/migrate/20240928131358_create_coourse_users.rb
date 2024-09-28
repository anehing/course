class CreateCoourseUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :coourse_users do |t|
      t.references :coourse, null: false
      t.references :user, null: false
      t.integer :role, default: 0, null: false
      t.string :name, null: false
      t.boolean :phantom, default: false, null: false
      t.datetime :last_active_time

      t.timestamps

      t.index [:coourse_id, :user_id], unique: true
    end
  end
end
