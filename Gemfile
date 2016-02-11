source 'https://rubygems.org'

# Specify your gem's dependencies in rails_importer.gemspec
gemspec

group :development, :test do
  gem 'sqlite3'
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'rspec-collection_matchers'
  gem 'factory_girl_rails'
  gem 'ffaker'
  gem "pry"
end

group :test do
  gem 'capybara', require: false
  gem 'selenium-webdriver'

  # Clean database after running test suite
  gem 'database_cleaner'
end
