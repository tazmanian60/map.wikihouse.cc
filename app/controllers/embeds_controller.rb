class EmbedsController < ApplicationController
  def show
    @places = Place.with_accepted_state
  end
end
