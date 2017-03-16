class Admin::PlaceStatesController < Admin::ApplicationController
  def update
    @place = Place.find(params[:id])

    if params[:button] == "accept"
      @place.accept!
    else
      @place.reject!
    end

    redirect_back fallback_location: admin_root_path
  end
end
