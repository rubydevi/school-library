require_relative '../app_code/person'
require_relative '../app_code/rental'

describe Person do
  let(:person) { Person.new(18, 'Bambi', parents_permission: true) }

  describe '#initialize' do
    it 'creates a new Person instance with attributes' do
      expect(person.age).to eq(18)
      expect(person.name).to eq('Bambi')
      expect(person.parents_permission).to be_truthy
      expect(person.rentals).to be_empty
      expect(person.id).to be_a(Integer)
    end
  end

  describe '#can_use_services?' do
    it 'returns true if parents permission is true' do
      expect(person.can_use_services?).to be_truthy
    end
  end

  describe '#add_rental' do
    it 'creates a new Rental instance and adds it to rentals' do
      book = double('Book')
      date = '2023-09-05'
      expect(Rental).to receive(:new).with(date, book, person)
      person.add_rental(date, book)
    end
  end
end
