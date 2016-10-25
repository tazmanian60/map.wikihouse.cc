class PlacesController < ApplicationController

  def index
    @places = Place.with_accepted_state.all
  end

  def show
    @place = Place.find(params[:id])
  end

  def new
    @place = klass.new
    authorize @place
  end

  def create
    @place = klass.new(place_params)
    authorize @place
    if @place.save
      notifier = Slack::Notifier.new ENV.fetch('slack_webhook_url')
      notifier.ping "New place added to map #{place_url(@place)}"
      redirect_to @place, notice: "Place added"
    else
      render :new
    end
  end

  private

    def place_params
      params.require(controller_name.singularize).permit!
    end

    def klass
      controller_name.singularize.classify.constantize
    end

end
