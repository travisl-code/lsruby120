module Display

  def show(message)
    puts "=> #{message}"
  end
end

module DisplayMenu
  attr_accessor :score
  include Display

  def show_menu
    puts "--------"
    puts self.score
  end
end

class Test
  include DisplayMenu

  def initialize(score)
    self.score = score
  end
end

test = Test.new('perfeeeeect')
test.show('howdy there')
test.show_menu
