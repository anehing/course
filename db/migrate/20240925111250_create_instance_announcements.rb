class CreateInstanceAnnouncements < ActiveRecord::Migration[7.2]
  def change
    create_table :instance_announcements do |t|
      t.references :instance, null: false
      t.string :title, null: false
      t.text :content
      t.datetime :start_at, null: false
      t.datetime :end_at, null: false
      t.bigint :creator_id, null: false
      t.bigint :updater_id, null: false

      t.timestamps null: false
    end
    add_index :instance_announcements, :creator_id
    add_index :instance_announcements, :updater_id

    add_foreign_key :instance_announcements, :users, column: :creator_id, name: "fk_instance_announcements_creator_id"
    add_foreign_key :instance_announcements, :users, column: :updater_id, name: "fk_instance_announcements_updater_id"
  end
end
