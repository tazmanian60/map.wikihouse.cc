class Admin::ReviewsController < Admin::ApplicationController
  def index
    @places = Place.with_awaiting_review_state
  end

  def update
    @place = Place.find(params[:id])

    if params[:button] == "accept"
      @place.accept!
    else
      @place.reject!
    end

    redirect_to admin_reviews_path
  end

  def show
    @place = Place.find(params[:id])
  end
end
