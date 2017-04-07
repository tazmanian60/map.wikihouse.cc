class PlacesController < ApplicationController
  TYPES = %w(Build Contributor)

  def index
    @places = Place.with_accepted_state.all
  end

  def show
    @place = Place.find(params[:id])
  end

  def new
    @place = klass.new
  end

  def create
    @place = klass.new(place_params)

    if @place.save
      ChatNotifier.default.place_created(@place)
      redirect_to thanks_url
    else
      render :new
    end
  end

  private

  def place_params
    params.require(controller_name.singularize)
          .permit(:name, :lat, :lng, :address, :notes, *klass.fields)
  end

  def klass
    if TYPES.include?(params[:type])
      params[:type].constantize
    else
      Place
    end
  end
end
