class Place < ApplicationRecord

  validates_presence_of :lat, :lng, :name

  include Workflow
  workflow do
    # state :new do
    #   event :submit, :transitions_to => :awaiting_review
    # end
    # state :awaiting_review do
    #   event :review, :transitions_to => :being_reviewed
    # end
    state :awaiting_review do
      event :accept, :transitions_to => :accepted
      event :reject, :transitions_to => :rejected
    end
    state :rejected do
      event :accept, :transitions_to => :accepted
    end
    state :accepted
  end

  def to_s
    name
  end

  def self.policy_class
    PlacePolicy
  end

  def safe_latlng(precision=2)
    # https://en.wikipedia.org/wiki/Decimal_degrees#Precision
    # 2: ~ 500m-1km precision
    # 3: ~ 50-100m precision
    [lat,lng].map{|f| sprintf("%.#{precision}f", f)}
  end
end
