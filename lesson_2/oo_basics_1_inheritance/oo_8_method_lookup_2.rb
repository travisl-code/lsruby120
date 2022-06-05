# Determine lookup path when invoking `cat1.color`. Only list classes Ruby checks.

# Cat > Animal > Object > Kernel > BasicObject

class Animal
end

class Cat < Animal
end

class Bird < Animal
end

cat1 = Cat.new
cat1.color
