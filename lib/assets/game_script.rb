require 'yaml'

# A class to interact with the yaml file containing all of the game's text.
class GameScript
  def self.script
    YAML.load_file(File.join(__dir__, './script.yml'))
  end

  def self.write_to_script
    add_to_script = {}
    new_content = script.merge(add_to_script)
    File.open('lib/assets/script.yml', 'w') { |f| f.write new_content.to_yaml }
  end
end
