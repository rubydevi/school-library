require_relative '../app_code/book'

describe Book do
  let(:book) { Book.new('The Lord of The Rings', 'J.R.R. Tolkien') }

  describe '#initialize' do
    it 'creates a new Book instance with title and author' do
      expect(book.title).to eq('The Lord of The Rings')
      expect(book.author).to eq('J.R.R. Tolkien')
      expect(book.rentals).to be_empty
    end
  end

  describe '#add_rental' do
    it 'creates a new Rental instance and adds it to rentals' do
      date = '2023-09-13'
      person = 'Molly'
      expect(Rental).to receive(:new).with(date, book, person)
      book.add_rental(date, person)
    end
  end
end
