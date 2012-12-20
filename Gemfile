source 'https://rubygems.org'

gem 'rails', '3.2.8'

#Database stuff
gem 'mysql2'

#Application server stuff
gem 'thin'

#Mixins and Sass stuff
gem "bourbon", "~> 0.2.1"
gem 'sass-rails',   '~> 3.2.3'

# Syuntaxic sugar apreciated when debuging
gem 'awesome_print'

# Facebook stuff
gem 'koala'

#Javascript-Library
gem 'jquery-rails'

#Deploy stuff
gem 'exception_notification_rails3', :require => 'exception_notifier'
gem 'capistrano'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'coffee-rails', '~> 3.2.1'
  gem 'therubyracer', "~> 0.10.2", :platforms => :ruby
  gem 'uglifier', '>= 1.0.3'
end

group :test, :development do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'factory_girl_generator'
  gem 'faker'
  gem 'guard-rspec'
  gem 'rb-fsevent'
end