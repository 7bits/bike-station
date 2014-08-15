class CreateBikeLocations < ActiveRecord::Migration
  def change
    create_table :bike_locations do |t|
      t.references :bike, index: true
      t.decimal :lat
      t.decimal :lng
      t.timestamp :date

      t.timestamps
    end
  end
end
