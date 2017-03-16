class Admin::PlacesController < Admin::ApplicationController
  def index
    @state  = params[:state] || "awaiting_review"
    @places = Place.order("created_at desc").where(workflow_state: @state)

    if @state == "awaiting_review"
      render "awaiting_review_index"
    else
      render "index"
    end
  end

  def show
    @place = Place.find(params[:id])
    @state = @place.workflow_state
  end
end
