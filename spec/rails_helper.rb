# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require 'factory_girl_rails'
include ApplicationHelper
ActiveRecord::Migration.maintain_test_schema!

# logger
# Rails.logger = Logger.new(STDOUT) # 追記
RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.include Capybara::DSL

  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!
end

def is_logged_in?
  !session[:user_id].nil?
end

def log_in_as(user)
  session[:user_id] = user.id
end
