class AddPriceToTrailers < ActiveRecord::Migration[5.2]
  def change
    add_column :trailers, :price, :decimal
  end
end
