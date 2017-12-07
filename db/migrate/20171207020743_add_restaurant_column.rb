class AddRestaurantColumn < ActiveRecord::Migration[5.1]
  def change
    add_column :restaurants, :name, :string
    add_column :restaurants, :tel, :string
    add_column :restaurants, :address, :string
    add_column :restaurants, :opening_hours, :string
    add_column :restaurants, :description, :text

  end
end


