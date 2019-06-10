class AddPictureToTrailers < ActiveRecord::Migration[5.2]
  def change
    add_column :trailers, :picture, :integer
  end
end
