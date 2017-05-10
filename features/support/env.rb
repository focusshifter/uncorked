require 'rspec'
require 'rack/test'

# require 'json-schema'

require 'database_cleaner'
require 'database_cleaner/cucumber'

ENV['RACK_ENV'] = 'test'
ENV['AUTH_SECRET'] = "Sw\xAC\xCBGg\xD8q<I\x8Di#\f\xE7\xECd\v\xBE\xD6\xAA\xC0\xEE\xA1\xF5\xC4\x8D\xA0\xEB\xA5\xEC\xE9"

require File.join(File.dirname(__FILE__), '..', '..', 'app', 'app')

DatabaseCleaner[:sequel].strategy = :truncation

# RSpec::Matchers.define :match_response_schema do |model|
#   match do |response|
#     schema_dir = File.join(File.dirname(__FILE__), '..', 'schema_definitions')
#     schema_path = File.join(schema_dir, "#{model}_schema.json")
#     JSON::Validator.validate!(schema_path, response)
#   end
# end

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
