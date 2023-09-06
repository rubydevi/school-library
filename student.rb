require_relative 'person'

class Student < Person
  attr_accessor :classroom

  def initialize(classroom, age, name = 'Unknown', parents_permission: true)
    super(age, name, parents_permission: parents_permission)
    @classroom = classroom
  end

  def play_hooky
    '¯\\(ツ)/¯'
  end

  def assign_classroom(classroom)
    self.classroom = classroom
    classroom&.add_student(self)
  end
end
