class Build < Place
  validates_presence_of :name

  def self.icon
    "home"
  end
end
