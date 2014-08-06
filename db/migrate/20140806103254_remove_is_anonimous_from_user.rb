class RemoveIsAnonimousFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :is_anonimous
  end
end
