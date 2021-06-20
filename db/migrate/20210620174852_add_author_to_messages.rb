class AddAuthorToMessages < ActiveRecord::Migration[6.1]
  def change
    add_column :messages, :author, :string
  end
end
