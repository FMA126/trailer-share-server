class AddAxelsToTrailer < ActiveRecord::Migration[5.2]
  def change
    add_column :trailers, :axels, :integer
  end
end
