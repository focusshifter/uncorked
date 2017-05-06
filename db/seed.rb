require 'sequel'

DB = Sequel.connect('sqlite://uncorked.db')

DB.create_table :wineries do
  primary_key :id
  String :name, null: false
  String :uuid, unique: true, null: false
  DateTime :created_at
  DateTime :updated_at

  index :created_at
end
