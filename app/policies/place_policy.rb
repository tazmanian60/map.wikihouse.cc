class PlacePolicy < ApplicationPolicy

  def create?
    user
  end

end