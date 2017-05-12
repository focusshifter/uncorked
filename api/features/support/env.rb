require 'rspec'
require 'rack/test'

# require 'json-schema'

require 'database_cleaner'
require 'database_cleaner/cucumber'

ENV['RACK_ENV'] = 'test'
ENV['UC_AUTH_SECRET'] = 'uncorked_secret'

require 'simplecov'
SimpleCov.start

require File.join(File.dirname(__FILE__), '..', '..', 'app', 'app')

DatabaseCleaner[:sequel].strategy = :truncation

# = UncorkedApiWorld
class UncorkedApiWorld
  include RSpec::Expectations
  include RSpec::Matchers
  include Rack::Test::Methods

  def app
    App.adapter
  end
end

World do
  UncorkedApiWorld.new
end

Before do
  DatabaseCleaner[:sequel].start
end

After do
  # FIXME: this is sqlite-only Sequel hack for wiping the DB
  # See https://github.com/jeremyevans/sequel/issues/872

  DB.run('PRAGMA foreign_keys = OFF;')
  DatabaseCleaner[:sequel].clean
  DB.run('PRAGMA foreign_keys = ON;')
end
