class CreateCourses < ActiveRecord::Migration[6.1]
  def change
    create_table :courses, id: :uuid do |t|
      t.string :title
      t.text :content
      t.string :slug
      t.references :level, null: false, foreign_key: true, type: :uuid
      t.references :material, null: false, foreign_key: true, type: :uuid
      t.references :user, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
    add_index :courses, :slug, unique: true
  end
end
