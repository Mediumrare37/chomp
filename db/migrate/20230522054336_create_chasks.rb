class CreateChasks < ActiveRecord::Migration[7.0]
  def change
    create_table :chasks do |t|
      t.string :title
      t.string :status, default: 'pending'
      t.references :task, null: false, foreign_key: true
      t.references :chask, null: true, foreign_key: true

      t.timestamps
    end
  end
end
