class AddStationIdToBike < ActiveRecord::Migration
  def change
    add_column :bikes, :station_id, :integer, index: true
  end
end
