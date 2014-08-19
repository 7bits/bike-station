class FixLocationView < ActiveRecord::Migration
  def up
    execute %{
      CREATE OR REPLACE VIEW locations as
        SELECT bike_id, lat, lng, dates.date
        FROM bike_locations, (
          SELECT max(date) as date
          FROM bike_locations
          GROUP BY bike_id
        ) as dates
        WHERE dates.date = bike_locations.date;
    }
  end

  def down
    execute 'DROP VIEW locations'
  end
end
