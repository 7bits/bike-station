class CreateStations < ActiveRecord::Migration
  def change
    create_table :stations do |t|
      t.decimal :latitude
      t.decimal :longitude
      t.string :name

      t.timestamps
    end
  end
end
