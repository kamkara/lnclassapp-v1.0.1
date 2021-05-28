class AddAuthorToCourse < ActiveRecord::Migration[6.1]
  def change
    add_column :courses, :author, :string
  end
end
