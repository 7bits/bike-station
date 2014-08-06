class AddNameToBike < ActiveRecord::Migration
  def change
    add_column :bikes, :name, :string
  end
end
