class ChangeColumnDefaultFavoritesCountToRestaurants < ActiveRecord::Migration[5.1]
  def change
    change_column_default :restaurants, :favorites_count, 0
  end
end
