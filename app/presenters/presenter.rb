class Presenter < SimpleDelegator
  attr_reader :helpers
  alias h helpers

  def initialize(object, helpers)
    super(object)
    @helpers = helpers
  end
end
