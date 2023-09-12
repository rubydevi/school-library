require 'pry'
require 'json'
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
  def create_person(type, age, name)
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
  def create_book(title, author)
    book = Book.new(title, author)

    @books << book
    puts "#{book.title} by #{book.author} successfully created!"
  end

  # option 5
  def create_rental(person_number, book_number, date)
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
  def list_rentals_for_person(person_id)
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

  # Preserve JSON data
  def save_data
    save_people
    save_books
    save_rentals
  end

  def load_data
    load_people
    load_books
    load_rentals
  end

  private

  def save_people
    if File.exist?('people.json')
      # Read the existing JSON data from the file
      existing_data = File.read('people.json')
      people_data = JSON.parse(existing_data)
      # binding.pry
    else
      people_data = [] 
    end

    # Serialize the new people data to a format suitable for JSON
    serialized_people = @people.map do |person|
      {
        'type' => person.class.to_s, # Store the class name for later deserialization
        'data' => person.instance_variables.each_with_object({}) do |var, hash|
          hash[var.to_s.delete('@')] = person.instance_variable_get(var)
        end
      }
    end

    # Append the serialized people data to the existing data
    people_data += serialized_people

    # Write the updated data to the file
    File.write('people.json', JSON.pretty_generate(people_data))
  end

  def load_people
    # body
  end

  def save_books
    File.write('books.json', @books.to_json)
  end

  def load_books
    @books = if File.exist?('books.json')
               JSON.parse(File.read('books.json'))
             else
               []
             end
  end

  def save_rentals
    File.write('rentals.json', @rentals.to_json)
  end

  def load_rentals
    @rentals = if File.exist?('rentals.json')
                 JSON.parse(File.read('rentals.json'))
               else
                 []
               end
  end
end
