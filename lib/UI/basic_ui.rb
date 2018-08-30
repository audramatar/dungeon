# Module to add basic UI functioning to classes.
module BasicUI
  def print_line(length = 30)
    puts '-' * length
  end

  def new_line(repeat = 1)
    puts "\n" * repeat
  end

  def print_icon(icon)
    print icon.ljust(3)
  end

  def print_to_screen(string)
    puts string
  end

  def ask_question(question)
    new_line
    puts Paint[question, :bold]
    print_line
    print '> '
    gets.chomp.downcase
  end

  def print_error_message(message)
    puts Paint[message, :red]
    new_line
  end
end
