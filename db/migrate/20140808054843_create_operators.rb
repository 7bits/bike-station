class CreateOperators < ActiveRecord::Migration
  def change
    create_table :operators do |t|
      t.string :email, null: false
      t.string :authentication_token
      t.boolean :approved, null: false, default: false

      t.timestamps
    end

    add_index :operators, :email, unique: true
    add_index :operators, :authentication_token, unique: true
  end
end