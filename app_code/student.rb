require_relative 'person'

class Student < Person
  attr_accessor :classroom, :type

  def initialize(age, name, parents_permission)
    super(age, name, parents_permission: parents_permission)
    @classroom = classroom
    @type = 'Student'
  end

  def play_hooky
    '¯\\(ツ)/¯'
  end

  def assign_classroom(classroom)
    self.classroom = classroom
    classroom&.add_student(self)
  end
end
