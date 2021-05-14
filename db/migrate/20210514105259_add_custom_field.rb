class AddCustomField < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :full_name, :string
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :city, :string
    add_column :users, :school_name, :string
    add_column :users, :matricule, :string
    add_column :users, :level_id, :uuid
    add_column :users, :material_id, :uuid
    add_column :users, :class_name, :string
    add_column :users, :birthday, :date
    add_column :users, :gender, :integer
    add_column :users, :phone_contact, :string
    add_column :users, :whatsapp_contact, :string
    add_column :users, :memo, :string
    add_column :users, :avatar, :string
    add_column :users, :role, :string,  default: :student
    add_column :users, :slug, :string
  end
end
