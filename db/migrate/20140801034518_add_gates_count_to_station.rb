class AddGatesCountToStation < ActiveRecord::Migration
  def change
    add_column :stations, :gates_count, :integer, null: false, default: 0
  end
end
