class AddRatesToRents < ActiveRecord::Migration
  def change
    add_column :rents, :rate_id, :integer, index: true
  end
end
