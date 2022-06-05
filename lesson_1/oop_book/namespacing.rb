module Animal
  # container example
  def self.out_of_place_method(num)
    num ** 2
  end

  class Dog
    def speak(sound)
      p "#{sound}"
    end
  end

  class Cat
    def say_name(name)
      p "#{name}"
    end
  end
end

sparky = Animal::Dog.new
paws = Animal::Cat.new
sparky.speak('Arf!')
paws.say_name('Paws')
