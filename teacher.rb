require_relative 'person'

class Teacher < Person
  def initialize(age, specialization, name: 'Unknown', parents_permission: true)
    super(age, name: name, parents_permission: parents_permission)
    @specialization = specialization
  end

  def can_use_services?
    true
  end
end
