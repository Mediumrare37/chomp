class AddDeadlineToChasks < ActiveRecord::Migration[7.0]
  def change
    add_column :chasks, :deadline, :date
  end
end
