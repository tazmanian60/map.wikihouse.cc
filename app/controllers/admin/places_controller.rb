class Admin::PlacesController < Admin::ApplicationController
  before_action :find_place, only: %w(show edit update)

  def index
    @state  = params[:state] || "awaiting_review"
    @places = Place.order("created_at desc").where(workflow_state: @state)

    if @state == "awaiting_review"
      render "awaiting_review_index"
    else
      render "index"
    end
  end

  def update
    if @place.update(params[:place].permit!)
      redirect_to admin_place_path(@place)
    else
      render "edit"
    end
  end

  private

  def find_place
    @place = Place.find(params[:id])
    @state = @place.workflow_state
  end
end
