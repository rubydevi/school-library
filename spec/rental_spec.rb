require_relative '../app_code/rental'
require_relative '../app_code/person'
require_relative '../app_code/book'

describe Rental do
  before(:each) do
    @date = '14-09-2023'
    @person = Person.new('Supreeti')
    @book = Book.new('New Title', 'New Book')
    @rental = Rental.new(@date, @book, @person)
  end

  context 'Create a new rental' do
    it 'sets the date, book, and person attributes' do
      expect(@rental.date).to eq(@date)
      expect(@rental.book).to eq(@book)
      expect(@rental.person).to eq(@person)
    end
  end

  context 'Check rental associations' do
    it 'adds the rental to the person rentals' do
      expect(@person.rentals).to include(@rental)
    end

    it 'adds the rental to the book rentals' do
      expect(@book.rentals).to include(@rental)
    end
  end
end
