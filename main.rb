require_relative 'app'

class Main
  def initialize
    @app = App.new
    run
  end

  def run
    puts 'Welcome to School Library App!'
    library_options
  end

  def library_options
    menu_options = create_menu_options

    loop do
      display_menu
      choice = gets.chomp.to_i

      if menu_options.key?(choice)
        handle_choice(menu_options[choice])
        break if choice == 7
      else
        puts 'Please choose a valid option from the options provided.'
      end
    end
  end

  def create_menu_options
    {
      1 => :list_all_books,
      2 => :list_all_people,
      3 => :create_person,
      4 => :create_book,
      5 => :create_rental,
      6 => :list_rentals_for_person,
      7 => :exit_library
    }
  end

  def handle_choice(choice)
    case choice
    when :create_book
      create_book
    else
      @app.send(choice)
    end
    # @app.send(choice)
  end

  # Refer this one for CREATE RENTAL
  def create_book
    print 'Enter title: '
    title = gets.chomp
    print 'Enter author: '
    author = gets.chomp
    @app.create_book(title, author)
  end

  def create_rental
    @app.list_all_people
    print 'Enter person serial number: '
    person_number = gets.chomp.to_i
    @app.list_all_books
    print 'Enter book serial number: '
    book_number = gets.chomp.to_i
    print 'Enter rental date: '
    date = gets.chomp
    @app.create_rental(person_number, book_number, date)
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
end

Main.new
