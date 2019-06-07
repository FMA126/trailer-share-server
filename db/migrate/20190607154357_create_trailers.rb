class CreateTrailers < ActiveRecord::Migration[5.2]
  def change
    create_table :trailers do |t|
      t.references :user, foreign_key: true
      t.text :make
      t.text :model
      t.integer :year
      t.text :trailer_type
      t.text :hitch_type
      t.integer :length
      t.integer :gvwr

      t.timestamps
    end
  end
end
