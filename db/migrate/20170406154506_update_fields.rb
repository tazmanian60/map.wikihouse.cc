class UpdateFields < ActiveRecord::Migration[5.0]
  def change
    Place.find_each do |place|
      place.update!(
        data: place.data.merge(
          "description" => place.description,
          "links"       => place.url,
        )
      )
    end

    change_table :places do |t|
      t.remove :description, :phone, :url, :images
    end
  end
end
