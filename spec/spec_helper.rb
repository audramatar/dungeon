require 'coveralls'
Coveralls.wear!

# This configuaration added to keep the output out of the console during testing.
RSpec.configure do |config|
  original_stderr = $stderr
  original_stdout = $stdout
  config.before(:all) do
    # Redirect stderr and stdout
    $stderr = File.new(File.join(File.dirname(__FILE__), 'dev', 'null.txt'), 'w')
    $stdout = File.new(File.join(File.dirname(__FILE__), 'dev', 'null.txt'), 'w')
  end
  config.after(:all) do
    $stderr = original_stderr
    $stdout = original_stdout
  end
end
