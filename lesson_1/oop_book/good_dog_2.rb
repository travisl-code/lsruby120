class GoodDog
  attr_accessor :name, :height, :weight

  def initialize(name, height, weight)
    @name = name
    @height = height
    @weight = weight
  end

  # The getter and setting aren't necessary with the attr_accessor method
  # def name
  #   @name
  # end

  # def name=(name)
  #   @name = name
  # end

  def change_info(n, h, w)
    self.name = n
    self.height = h
    self.weight = w
  end

  def info
    "#{name} weighs #{weight} and is #{height} tall."
  end

  def speak
    "#{name} says arf!"
  end
end

sparky = GoodDog.new("Sparky", "12 inces", "10 lbs")
puts sparky.info

sparky.change_info("Spartacus", "24 inches", "45 lbs")
puts sparky.info
