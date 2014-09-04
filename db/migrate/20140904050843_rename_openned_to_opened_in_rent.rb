class RenameOpennedToOpenedInRent < ActiveRecord::Migration
  def change
    rename_column :rents, :openned_at, :opened_at
  end
end
