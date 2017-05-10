require 'sequel'

dbname = "uncorked_#{ENV.fetch('RACK_ENV', 'development')}"

DB = Sequel.connect("sqlite://db/#{dbname}.db")
