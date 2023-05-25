class AddTotalpointsToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :totalpoints, :int, default: 0
    add_column :users, :daypoints, :int, default: 0
  end
end
