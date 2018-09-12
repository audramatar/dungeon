# Module to add basic UI functioning to classes.
module BasicUI
  def print_line(length = 60)
    puts '-' * length
  end

  def new_line(repeat = 1)
    puts "\n" * repeat
  end

  def clear_screen
    system 'clear'
  end

  def print_icon(icon)
    if icon == 'C'
      print Paint[icon.ljust(3), :bold]
    else
      print icon.ljust(3)
    end
  end

  def print_to_screen(string)
    puts string
  end

  def ask_question(question = nil, tips = nil, options = nil)
    new_line if question
    puts Paint[question, :bold] if question
    if options
      options.each do |option|
        print "[#{option}]".ljust(15)
      end
      new_line
    end

    tips.each { |tip| puts "Tip! #{tip}" } if tips

    print_line
    print '> '
    gets.chomp.downcase
  end

  def print_error_message(message)
    puts Paint[message, :red]
    new_line
  end

  def pause
    puts 'Press [enter] to continue...'
    gets.chomp
  end
end
