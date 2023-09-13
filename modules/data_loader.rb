module DataLoader
  def load_people
    File.new('people.json', 'w') unless File.exist?('people.json')
    people = File.read('people.json')
    return if people.empty?

    JSON.parse(people).each do |person|
      if person['type'] == 'Student'
        @people.push(Student.new(person['age'], person['name'], person['parents_permission']))
      elsif person['type'] == 'Teacher'
        @people.push(Teacher.new(person['age'], person['specialization'], person['name']))
      end
    end
  end

  def load_books
    File.new('books.json', 'w') unless File.exist?('books.json')
    books = File.read('books.json')
    return if books.empty?

    JSON.parse(books).each do |book|
      @books.push(Book.new(book['title'], book['author']))
    end
  end

  def load_rentals
    File.new('rentals.json', 'w') unless File.exist?('rentals.json')
    rentals = File.read('rentals.json')
    return if rentals.empty?

    JSON.parse(rentals).each do |rental|
      book_rented = @books.find { |book| book.title == rental['book'] }
      person_renting = @people.find { |person| person.name == rental['person'] }
      @rentals.push(Rental.new(rental['date'], book_rented, person_renting))
    end
  end
end
