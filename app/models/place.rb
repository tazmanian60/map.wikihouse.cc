class Place < ApplicationRecord
  validates_presence_of :name, :description, :lat, :lng

  include Workflow
  workflow do
    state :new do
      event :submit, :transitions_to => :awaiting_review
    end
    state :awaiting_review do
      event :review, :transitions_to => :being_reviewed
    end
    state :being_reviewed do
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

end
