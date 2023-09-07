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

  def run
    puts 'Welcome to School Library App!'
    library_options
  end

  def library_options
    menu_options = {
      1 => :list_all_books,
      2 => :list_all_people,
      3 => :create_person,
      4 => :create_book,
      5 => :create_rental,
      6 => :list_rentals_for_person,
      7 => :exit_library
    }

    loop do
      display_menu
      choice = gets.chomp.to_i

      if menu_options.key?(choice)
        send(menu_options[choice])
        break if choice == 7
      else
        puts 'Please choose a valid option from the options provided.'
      end
    end
  end

  def display_menu
    puts "\nPlease choose an option by entering a number:"
    puts '1 - List all books'
    puts '2 - List all people'
    puts '3 - Create a person'
    puts '4 - Create a book'
    puts '5 - Create a rental'
    puts '6 - List all rentals for a given person id'
    puts '7 - Exit'
    print 'Select an option (1-7): '
  end

  def exit_library
    puts "\nThanks for using my library!"
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

    case type
    when 1
      create_student
    when 2
      create_teacher
    else
      puts 'Oops! You have entered an invalid choice. Please start again.'
      nil
    end
  end

  # option 3.1
  def create_student
    print 'Age: '
    age = gets.chomp.to_i
    print 'Name: '
    name = gets.chomp
    print 'Has parent\'s permission? (Y/N): '
    permission = gets.chomp
    person = Student.new(age, name, permission)

    @people << person
    puts "Congratulations #{person.name}, you have successfully created a student! Here is your ID: #{person.id}"
  end

  # option 3.2
  def create_teacher
    print 'Age: '
    age = gets.chomp.to_i
    print 'Name: '
    name = gets.chomp
    print 'Specialization: '
    specialization = gets.chomp
    person = Teacher.new(age, specialization, name)

    @people << person
    puts "Congratulations #{person.name}, you have successfully created a teacher! Here is your ID: #{person.id}"
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
    person_serial_number = gets.chomp.to_i
    list_all_books
    print 'Enter book serial number: '
    book_id = gets.chomp.to_i
    print 'Enter rental date: '
    date = gets.chomp
    person = @people[person_serial_number - 1]
    book = @books[book_id - 1]

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
