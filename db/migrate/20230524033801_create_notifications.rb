class CreateNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications do |t|
      t.references :user, polymorphic: true, null: false
      t.references :object, polymorphic: true, null: false
      t.string :message
      t.boolean :read

      t.timestamps
    end
  end
end
