class CreateInstances < ActiveRecord::Migration[7.2]
  def change
    create_table :instances do |t|
      t.string :host, null: false, index: { unique: true },
      comment: 'Stores the host name of the instance. The www prefix is automatically '\
        'handled by the application'
      t.timestamps
    end
  end
end
