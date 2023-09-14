module DataSaver
  def save_people
    people_data = []

    @people.map do |person|
      if person.instance_of?(Student)
        people_data.push({ name: person.name, age: person.age,
                           parents_permission: person.parents_permission,
                           classroom: person.classroom, type: 'Student' })
      elsif person.instance_of?(Teacher)
        people_data.push({ name: person.name, age: person.age,
                           parents_permission: person.parents_permission,
                           specialization: person.specialization, type: 'Teacher' })
      end
    end
    File.write('data/people.json', JSON.pretty_generate(people_data))
  end

  def save_books
    books_data = []
    @books.each do |book|
      books_data.push({ title: book.title, author: book.author })
    end
    File.write('data/books.json', JSON.pretty_generate(books_data))
  end

  def save_rentals
    rentals_data = []
    @rentals.each do |rental|
      rentals_data.push({ date: rental.date, book: rental.book.title, person: rental.person.name })
    end
    File.write('data/rentals.json', JSON.pretty_generate(rentals_data))
  end
end
