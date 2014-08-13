class CreateRates < ActiveRecord::Migration
  def change
    create_table :rates do |t|
      t.string :name
      t.decimal :price
      t.timestamp :closed_at
    end
  end
end
