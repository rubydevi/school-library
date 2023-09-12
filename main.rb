require_relative 'app'
require_relative 'menu'

class Main
  def initialize
    @app = App.new
    @menu = Menu.new
    @app.load_data
    run
  end

  def run
    puts 'Welcome to School Library App!'
    library_options
  end

  def library_options
    menu_options = create_menu_options

    loop do
      @menu.display_menu
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
      6 => :list_rentals,
      7 => :exit_library
    }
  end

  def handle_choice(choice)
    case choice
    when :create_person
      create_person
    when :create_book
      create_book
    when :create_rental
      create_rental
    when :list_rentals
      list_rentals
    when :exit_library
      exit_library
    else
      @app.send(choice)
    end
  end

  def create_person
    puts 'Do you want to create a student (1) or a teacher (2)? [Input the number]: '
    type = gets.chomp.to_i

    print 'Age: '
    age = gets.chomp.to_i
    print 'Name: '
    name = gets.chomp
    @app.create_person(type, age, name)
  end

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

  def list_rentals
    @app.list_all_people
    print 'Enter person\'s ID: '
    person_id = gets.chomp.to_i
    @app.list_rentals_for_person(person_id)
  end

  def exit_library
    @app.save_data
    puts "\nThanks for using my library!"
  end
end

Main.new
