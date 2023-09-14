require_relative '../app_code/person'
require_relative '../app_code/rental'

describe Person do
  let(:person) { Person.new(18, 'Bambi', parents_permission: true) }
  let(:person_without_name) { Person.new(18, parents_permission: true) }

  let(:adult_without_permission) { Person.new(18, 'Jesse Pinkman', parents_permission: false) }
  let(:minor_with_permission) { Person.new(16, 'Simba', parents_permission: true) }
  let(:minor_without_permission) { Person.new(16, 'Mojo Jojo', parents_permission: false) }

  # initialize
  it 'creates a new Person instance with attributes' do
    expect(person.age).to eq(18)
    expect(person.name).to eq('Bambi')
    expect(person.parents_permission).to be_truthy
    expect(person.rentals).to be_empty
    expect(person.id).to be_a(Integer)
  end

  it 'sets a default name if not provided' do
    expect(person_without_name.age).to eq(18)
    expect(person_without_name.name).to eq('Unknown')
    expect(person_without_name.parents_permission).to be_truthy
    expect(person_without_name.rentals).to be_empty
    expect(person_without_name.id).to be_a(Integer)
  end

  # can_use_services?'
  it 'returns true if parents permission is true' do
    expect(person.can_use_services?).to be_truthy
    expect(minor_with_permission.can_use_services?).to be_truthy
  end

  it 'returns false if under age and no parent permission' do
    expect(minor_without_permission.can_use_services?).to be_falsey
  end

  it 'returns true if over age and no parent permission' do
    expect(adult_without_permission.can_use_services?).to be_truthy
  end

  # correct_name
  it 'returns name correctly' do
    expect(person.correct_name).to eq('Bambi')
  end

  # add_rental
  it 'creates a new Rental instance and adds it to rentals' do
    book = double('Book')
    date = '2023-09-05'
    expect(Rental).to receive(:new).with(date, book, person)
    person.add_rental(date, book)
  end
end
