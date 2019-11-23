# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.5'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.1'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 4.1'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

gem 'active_model_serializers'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

# pagination
gem 'kaminari'

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]

  # content generation
  gem 'factory_bot_rails'
  gem 'faker'

  # debugger with Pry
  gem 'pry-byebug'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'

  # Pry as console
  gem 'pry-rails'

  # Style Guides
  gem 'rubocop', require: false
  gem 'rubocop-rspec', require: false
end

group :test do
  # Only for resetting PostgreSQL counters in tests
  gem 'database_cleaner'

  # Pretty progressbar while rspec running
  gem 'fuubar'

  # test responses
  gem 'json_spec'

  # Checking N + 1
  gem 'n_plus_one_control'

  gem 'rspec-rails'

  # Test validations & assocations
  gem 'shoulda-matchers'

  # let_it_be & before_all
  gem "test-prof"

  # test time conditions
  gem 'timecop'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
