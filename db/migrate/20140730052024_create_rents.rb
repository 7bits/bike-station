class CreateRents < ActiveRecord::Migration
  def change
    create_table :rents do |t|
      t.references :bike, index: true
      t.references :user, index: true
      t.timestamp :openned_at
      t.timestamp :closed_at

      t.timestamps
    end
  end
end
