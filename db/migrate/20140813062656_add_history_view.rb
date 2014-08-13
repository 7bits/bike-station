class AddHistoryView < ActiveRecord::Migration
  def up
    execute %{
      CREATE OR REPLACE VIEW rents_history as
        SELECT
          COUNT(*) AS count,
          array_agg(rents.id) as rents_ids,
          (DATE_TRUNC('day', (closed_at::timestamptz - INTERVAL '0 hour')) + INTERVAL '0 hour') AS day
        FROM rents
        WHERE (closed_at IS NOT NULL)
        GROUP BY day;
    }
  end

  def down
    execute 'DROP VIEW rents_history'
  end
end
