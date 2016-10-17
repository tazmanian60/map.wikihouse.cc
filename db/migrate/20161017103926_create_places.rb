class CreatePlaces < ActiveRecord::Migration[5.0]
  def change
    create_table :places do |t|
      t.string :name
      t.text :description
      t.float :lat
      t.float :lng
      t.text :address
      t.string :phone
      t.string :url
      t.string :type

      t.timestamps
    end
    add_index :places, :type
  end
end
