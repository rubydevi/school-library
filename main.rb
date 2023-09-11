require_relative 'app'

def main
  App.new
  run
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

main
