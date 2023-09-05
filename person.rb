require_relative 'nameable'

class Person < Nameable
  attr_accessor :name, :age
  attr_reader :id

  def initialize(age, name = 'Unknown', parents_permission: true)
    super()
    @id = Random.rand(1..999)
    @name = name
    @age = age
    @parents_permission = parents_permission
  end

  def can_use_services?
    @parents_permission || of_age?
  end

  def correct_name
    @name
  end

  private

  def of_age
    @age >= 18
  end
end
