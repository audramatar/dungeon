module PlayerCharacterUtilities
  def show_character_map(map, location)
    system 'clear'
    x_max = map.keys.max_by { |x| x[0] }[0]
    y_max = map.keys.max_by { |y| y[1] }[1]
    x_min = map.keys.min_by { |x| x[0] }[0]
    y_min = map.keys.min_by { |y| y[1] }[1]

    draw_character_map(map, location, x_max, y_max, x_min, y_min)
  end
end
