class Build < Place
  field :stage
  field :contributors

  def self.icon
    "home"
  end
end
