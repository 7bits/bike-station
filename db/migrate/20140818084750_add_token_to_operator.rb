class AddTokenToOperator < ActiveRecord::Migration
  def change
    add_column :operators, :token, :string, index: :unique
  end
end
