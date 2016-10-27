class AddNotesToPlaces < ActiveRecord::Migration[5.0]
  def change
    add_column :places, :notes, :text
  end
end
