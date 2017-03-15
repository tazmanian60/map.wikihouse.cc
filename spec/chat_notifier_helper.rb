require "rails_helper"

describe ChatNotifier do
  fixtures :places

  let(:messages) { [] }

  subject { ChatNotifier.new(messages.method(:<<)) }

  it "notifies when a place has been created" do
    subject.place_created(places(:contributor))
  end
end
