require 'simplecov'
require 'simplecov-console'
SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
  SimpleCov::Formatter::Console,
  # Want a nice code coverage website? Uncomment this next line!
  # SimpleCov::Formatter::HTMLFormatter
])
SimpleCov.start

# Require all the testing gems
require 'capybara'
require 'capybara/rspec'
require 'rspec'
require_relative './setup_test_database'
require_relative './web_helpers'
# Bring in the contents of the `app.rb` file
require File.join(File.dirname(__FILE__), '..', 'app.rb')

ENV['ENVIRONMENT'] = 'test'
ENV['RACK_ENV'] = 'test'

RSpec.configure do |config|
  config.before(:each) do
    setup_test_database
  end
end

# Tell Capybara to talk to ChitterManager
Capybara.app = ChitterManager

RSpec.configure do |config|
  config.after(:suite) do
    puts
    puts "\e[33mHave you considered running rubocop? It will help you improve your code!\e[0m"
    puts "\e[33mTry it now! Just run: rubocop\e[0m"
  end
end
