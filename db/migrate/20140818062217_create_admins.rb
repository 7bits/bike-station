class CreateAdmins < ActiveRecord::Migration
  def change
    create_table :admins do |t|
      t.string :email, index: :unique, null: false

      t.timestamps
    end
  end
end
