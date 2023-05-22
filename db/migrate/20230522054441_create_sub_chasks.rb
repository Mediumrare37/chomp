class CreateSubChasks < ActiveRecord::Migration[7.0]
  def change
    create_table :sub_chasks do |t|
      t.string :title
      t.string :status, default: 'pending'
      t.references :chask, null: false, foreign_key: true

      t.timestamps
    end
  end
end
