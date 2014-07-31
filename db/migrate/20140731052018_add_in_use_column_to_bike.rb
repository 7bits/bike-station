class AddInUseColumnToBike < ActiveRecord::Migration
  def change
    add_column :bikes, :in_use, :boolean, default: false
  end
end
