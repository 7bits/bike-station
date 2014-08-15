class ChangePriceTypeToInteger < ActiveRecord::Migration
  def change
    change_column :rates, :price, :integer
  end
end
