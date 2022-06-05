class Student
  attr_reader :name
  def initialize(name, grade)
    @name = name
    @grade = grade
  end

  def better_grade_than?(other_student)
    grade > other_student.grade
  end

  protected
  attr_accessor :grade
end

travis = Student.new('Travis', 96)
bob = Student.new('Bob', 87)
# puts travis.name
# puts travis.grade # Exception as expected
puts "Well done!" if travis.better_grade_than?(bob)