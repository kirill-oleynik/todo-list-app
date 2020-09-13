# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'
gem 'active_model_serializers', '~> 0.10.10'
gem 'bcrypt', '~> 3.1.7'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'jwt_sessions', '~> 2.5', '>= 2.5.2'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.1'
gem 'rails', '~> 6.0.3', '>= 6.0.3.3'

group :development, :test do
  gem 'awesome_print', '~> 1.8'
  gem 'bullet', '~> 6.1'
  gem 'factory_bot_rails', '~> 6.1'
  gem 'faker', '~> 2.13'
  gem 'pry-rails', '~> 0.3.9'
  gem 'rubocop-rails', '~> 2.8'
end
group :test do
  gem 'database_cleaner', '~> 1.8', '>= 1.8.5'
  gem 'json_matchers', '~> 0.11.1'
  gem 'rspec-rails', '~> 4.0', '>= 4.0.1'
  gem 'shoulda-matchers', '~> 4.4', '>= 4.4.1'
end

group :development do
  gem 'fasterer', '~> 0.8.3'
  gem 'jsonlint', '~> 0.3.0'
  gem 'listen', '~> 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
