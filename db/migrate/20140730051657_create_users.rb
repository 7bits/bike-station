class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :surname
      t.boolean :is_anonimous

      t.timestamps
    end
  end
end
