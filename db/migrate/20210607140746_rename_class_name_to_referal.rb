class RenameClassNameToReferal < ActiveRecord::Migration[6.1]
  def change
    rename_column :users, :class_name, :referral
  end
end
