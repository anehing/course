class CreateCoourses < ActiveRecord::Migration[7.2]
  def change
    create_table :coourses do |t|
      t.references :instance, null: false
      t.string :title, null: false
      t.text :description
      t.integer :status, default: 0, null: false
      t.datetime :start_at, null: false
      t.datetime :end_at, null: false
      t.bigint :creator_id, null: false

      t.timestamps
    end
    add_index :coourses, :creator_id
    add_foreign_key :coourses, :users, column: :creator_id, name: "fk_courses_creator_id"
  end
end
