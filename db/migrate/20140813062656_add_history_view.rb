class AddHistoryView < ActiveRecord::Migration
  def up
    execute %{
      CREATE OR REPLACE VIEW rents_history as
        SELECT
          COUNT(*) AS count,
          all_rents.station_id,
          array_agg(all_rents.id) as rents_ids,
          (DATE_TRUNC('day', (all_rents.closed_at::timestamptz - INTERVAL '0 hour')) + INTERVAL '0 hour')::date AS day
        FROM (
          SELECT rents.closed_at, rents.id, rents.terminal_station_id as station_id
          FROM rents
          UNION
          SELECT rents.closed_at, rents.id, rents.starting_station_id as station_id
          FROM rents
        ) as all_rents
        WHERE (closed_at IS NOT NULL)
        GROUP BY day, all_rents.station_id;
    }
  end

  def down
    execute 'DROP VIEW rents_history'
  end
end
