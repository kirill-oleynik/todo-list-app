# frozen_string_literal: true

RSpec.configure do |config|
  # fore the entire test suite runs,clear the test database out completely
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  # default database cleaning strategy to be transactions.
  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  # only runs before examples which have been flagged :js => true.
  config.before(:each, js: true) do
    DatabaseCleaner.strategy = :truncation
  end

  # WRap each test with DBCleaner
  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
