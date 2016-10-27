require 'nokogiri'

def clean(s, indentation=0)
  str = "\t"*0
  str += s.strip
  return str
end

namespace :import do
  task kml: :environment do
    xml = Nokogiri::XML(File.open("communities.kml"))
    xml.css('Folder').each do |folder|
      folder_name = clean(folder.css("> name").text)

      folder.css('Placemark').each do |placemark|
        name = clean(placemark.css("name").text,1)
        point = clean(placemark.css("Point").text,2)
        description = clean(placemark.css("description").text,2)
        images = clean(placemark.css("Data[name=gx_media_links]").text,2) # images

        if folder_name == "Teams & Contributors"
          klass = Organisation
        else
          klass = Build
        end

          puts klass.create!(
            name: name,
            lng: point.split(",")[0],
            lat: point.split(",")[1],
            description: description.blank? ? nil : description,
            images: images.blank? ? nil : images,
            workflow_state: 'accepted'
          ).inspect
      end

    end
  end
end