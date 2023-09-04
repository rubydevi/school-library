class Person
  def initialize(age, name: 'Unknown', parents_permission: true)
    @id = Random.rand(1..999)
    @name = name
    @age = age
    @parents_permission = parents_permission
  end

  attr_accessor :name, :age
  attr_reader :id

  private

  def of_age
    @age >= 18
  end

  def can_use_services?
    @parents_permission || of_age?
  end
end
