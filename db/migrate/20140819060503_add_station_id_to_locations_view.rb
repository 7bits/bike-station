class AddStationIdToLocationsView < ActiveRecord::Migration
  def up
    execute %{
      CREATE OR REPLACE VIEW locations as
        SELECT bike_id, lat, lng, dates.date, bikes.station_id
        FROM bike_locations, bikes, (
          SELECT max(date) as date
          FROM bike_locations
          GROUP BY bike_id
        ) as dates
        WHERE bikes.id = bike_locations.bike_id AND dates.date = bike_locations.date;
    }
  end

  def down
    execute 'DROP VIEW locations'
  end
end
