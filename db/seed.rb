require 'sequel'

DB = Sequel.connect('sqlite://uncorked.db')

DB.create_table :wineries do
  primary_key :id
  String :title, null: false
  String :uuid, unique: true, null: false
  DateTime :created_at
  DateTime :updated_at

  index :created_at
end

DB.create_table :wines do
  primary_key :id
  String :title, null: false
  String :uuid, unique: true, null: false
  DateTime :created_at
  DateTime :updated_at

  index :created_at
end

DB.create_table :reviews do
  primary_key :id
  String :title, null: false
  Integer :rating, null: false
  String :uuid, unique: true, null: false
  DateTime :created_at
  DateTime :updated_at

  index :created_at
end

DB.create_table :users do
  primary_key :id
  String :email, null: false
  String :name
  String :uuid, unique: true, null: false
  DateTime :created_at
  DateTime :updated_at

  index :created_at
end
