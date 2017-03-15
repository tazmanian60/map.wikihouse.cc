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
      begin
        notifier = Slack::Notifier.new ENV.fetch('slack_webhook_url')
        notifier.ping "#{@place.name} (#{@place.type}) added #{place_url(@place)}?review=1"
      rescue
      end
      redirect_to thanks_url
    else
      render :new
    end
  end

  def transition
    @place = Place.find(params[:id])
    @place.send(params[:state_name] + "!")
    redirect_back fallback_location: @place
  end

  private

    def place_params
      params.require(controller_name.singularize).permit!
    end

    def klass
      controller_name.singularize.classify.constantize
    end

end
