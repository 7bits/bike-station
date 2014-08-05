class AddUuidToBikes < ActiveRecord::Migration
  def change
    add_column :bikes, :uuid, :string, index: {unique: true}, null: false
    add_column :bikes, :registration_id, :string
  end
end
