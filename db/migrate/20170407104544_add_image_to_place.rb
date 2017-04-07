class AddImageToPlace < ActiveRecord::Migration[5.0]
  def up
    add_attachment :places, :image
  end

  def down
    remove_attachment :places, :image
  end
end
