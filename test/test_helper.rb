ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/pride'
require 'capybara/rails'
require 'database_cleaner'

## required for stubbing
require 'mocha/setup'

DatabaseCleaner.strategy = :truncation, {except: %w[public.schema_migrations]}

class MiniTest::Test
  def setup
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end
end
class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!
#   # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
#   fixtures :all
#
#   # config.backtrace_exclusion_patterns << %r{/gems/}
end
