class Individual < Place
  # alias :first_name, to: :name
  attr_accessor :data,
    :first_name,
    :last_name,
    :email,
    :role

  validates_presence_of :first_name, :last_name

  def name
    [first_name, last_name].join(" ")
  end

  def singular_name
    "Your"
  end

end
