class RemoveGatesCountFromStation < ActiveRecord::Migration
  def change
    remove_column :stations, :gates_count
  end
end
