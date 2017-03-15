require 'capybara/rails'
require 'capybara/poltergeist'
Capybara.default_driver = :poltergeist

require 'database_cleaner'

RSpec.configure do |config|
  config.use_transactional_fixtures = false

  config.around do |example|
    if example.metadata[:type] == :feature
      DatabaseCleaner.strategy = :deletion
    else
      DatabaseCleaner.strategy = :transaction
    end

    DatabaseCleaner.cleaning { example.call }
  end
end
