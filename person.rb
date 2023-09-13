require_relative 'nameable'

class Person < Nameable
  attr_accessor :name, :age, :rentals, :parents_permission
  attr_reader :id

  def initialize(age, name = 'Unknown', parents_permission: true)
    super()
    @id = Random.rand(1..999)
    @name = name
    @age = age
    @parents_permission = parents_permission
    @rentals = []
  end

  def can_use_services?
    @parents_permission || of_age?
  end

  def correct_name
    @name
  end

  def add_rental(date, book)
    Rental.new(date, book, self)
  end

  private

  def of_age
    @age >= 18
  end
end
