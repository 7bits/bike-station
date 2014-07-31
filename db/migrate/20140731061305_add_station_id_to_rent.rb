class AddStationIdToRent < ActiveRecord::Migration
  def change
    add_column :rents, :terminal_station_id, :integer, index: true
    add_column :rents, :starting_station_id, :integer, index: true, null: false
  end
end
