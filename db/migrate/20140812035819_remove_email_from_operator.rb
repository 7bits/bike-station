class RemoveEmailFromOperator < ActiveRecord::Migration
  def change
    remove_column :operators, :email
    add_column :operators, :uid, :string, null: false
    add_column :operators, :name, :string, null: false
    add_column :operators, :provider, :string
    add_column :operators, :url, :string
  end
end
