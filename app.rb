require_relative 'book'
require_relative 'rental'
require_relative 'student'
require_relative 'teacher'

class App
  def initialize
    @people = [] # Array to store people (teachers and students)
    @books = [] # Array to store books
    @rentals = [] # Array to store rentals
  end

  # option 1
  def list_all_books
    if @books.length.positive?
      puts 'List of all books:'
      @books.each_with_index do |book, index|
        puts "#{index + 1}. Title: #{book.title}, Author: #{book.author}"
      end
    else
      puts "\nSorry, your library is currently empty!"
    end
  end

  # option 2
  def list_all_people
    if @people.length.positive?
      puts 'List of all people:'
      @people.each_with_index do |person, index|
        puts "#{index + 1}. ID: #{person.id}, Name: #{person.name}, Age: #{person.age}"
      end
    else
      puts "\nSorry, there isn't anyone in the library yet!"
    end
  end

  # option 3
  def create_person
    puts 'Do you want to create a student (1) or a teacher (2)? [Input the number]: '
    type = gets.chomp.to_i
    
    print 'Age: '
    age = gets.chomp.to_i
    print 'Name: '
    name = gets.chomp

    case type
    when 1
      create_student(age, name)
    when 2
      create_teacher(age, name)
    else
      puts 'Oops! You have entered an invalid choice. Please start again.'
      nil
    end
  end

  # option 3.1
  def create_student(age, name)
    print 'Has parent\'s permission? (Y/N): '
    permission = gets.chomp
    person = Student.new(age, name, permission)

    insert_person(person)
  end

  # option 3.2
  def create_teacher(age, name)
    print 'Specialization: '
    specialization = gets.chomp
    person = Teacher.new(age, specialization, name)

    insert_person(person)
  end

  def insert_person(person)
    @people << person
    puts "Congratulations #{person.name}, you have successfully created a student! Here is your ID: #{person.id}"
  end

  # option 4
  def create_book
    print 'Enter title: '
    title = gets.chomp
    print 'Enter author: '
    author = gets.chomp
    book = Book.new(title, author)

    @books << book
    puts "#{book.title} by #{book.author} successfully created!"
  end

  # option 5
  def create_rental
    list_all_people
    print 'Enter person serial number: '
    person_number = gets.chomp.to_i
    list_all_books
    print 'Enter book serial number: '
    book_number = gets.chomp.to_i
    print 'Enter rental date: '
    date = gets.chomp
    person = @people[person_number - 1]
    book = @books[book_number - 1]

    if person.nil? || book.nil?
      puts 'Invalid person or book ID.'
      return
    end

    rental = Rental.new(date, book, person)
    @rentals << rental
    puts "Rental created: #{person.name} rented #{book.title} on #{date}."
  end

  # option 6
  def list_rentals_for_person
    list_all_people
    print 'Enter person\'s ID: '
    person_id = gets.chomp.to_i

    person = @people.find { |pers| pers.id == person_id }

    if person.nil?
      puts 'Invalid person ID.'
      return
    end

    puts "Rentals for #{person.name}:"
    rentals = @rentals.select { |rental| rental.person.id == person_id }

    if rentals.empty?
      puts 'No rentals found for this person.'
    else
      rentals.each do |rental|
        puts "  Book: #{rental.book.title}, Date: #{rental.date}"
      end
    end
  end
end
