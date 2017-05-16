source 'https://rubygems.org'

gem 'bcrypt', '3.1.11'
gem 'bootstrap-sass', '3.3.6'
gem 'carrierwave',  '0.11.2'
gem 'coffee-rails', '4.2.1'
gem 'faker',        '1.6.6'
gem 'fog',          '1.38.0'
gem 'grape'
gem 'haml-rails',   '~> 0.9'
gem 'jbuilder',     '2.4.1'
gem 'jquery-rails', '4.1.1'
gem 'kaminari'
gem 'mini_magick',  '4.5.1'
gem 'puma',         '3.4.0'
gem 'rails',        '5.0.2'
gem 'sass-rails',   '5.0.6'
gem 'turbolinks',   '5.0.1'
gem 'uglifier',     '3.0.0'

group :development, :test do
  gem 'byebug', '9.0.0', platform: :mri
  gem 'factory_girl_rails'
  gem 'rspec-rails', '3.5'
  gem 'rubocop', require: false
  gem 'sqlite3', '1.3.11'
end

group :development do
  gem 'bullet'
  gem 'erb2haml'
  gem 'listen',                '3.0.8'
  gem 'spring',                '1.7.2'
  gem 'spring-watcher-listen', '2.0.0'
  gem 'web-console',           '3.1.1'
end

group :test do
  gem 'capybara', '2.8'
  gem 'cucumber-rails', require: false
  gem 'database_cleaner'
  gem 'guard', '2.13.0'
  gem 'guard-minitest', '2.4.4'
  gem 'minitest-reporters',       '1.1.9'
  gem 'rails-controller-testing', '0.1.1'
  gem 'selenium-webdriver', '2.35.1'
  gem 'turnip'
end

group :production do
  gem 'pg', '0.18.4'
end

# Windows環境ではtzinfo-dataというgemを含める必要があります
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
