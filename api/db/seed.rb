require 'sequel'

%w[uncorked_development uncorked_test uncorked_production].each do |dbname|
  path = File.join(File.dirname(__FILE__), dbname)

  db = Sequel.connect("sqlite://#{path}.db")

  db.create_table(:users) do
    primary_key :id
    String :email, size: 255, null: false
    String :name, size: 255
    String :uuid, size: 255, null: false
    DateTime :created_at
    DateTime :updated_at
  end

  db.create_table(:wineries, ignore_index_errors: true) do
    primary_key :id
    String :title, size: 255, null: false
    String :uuid, size: 255, null: false
    DateTime :created_at
    DateTime :updated_at

    index [:created_at]
  end

  db.create_table(:wines) do
    primary_key :id
    String :title, size: 255, null: false
    String :uuid, size: 255, null: false
    foreign_key :winery_id, :wineries, type: String, text: true, null: false, key: [:id]
    DateTime :created_at
    Integer :updated_at
  end

  db.create_table(:reviews) do
    primary_key :id
    Integer :rating, null: false
    String :uuid, size: 255, null: false
    foreign_key :wine_id, :wines, null: false, key: [:id]
    foreign_key :user_id, :users, null: false, key: [:id]
    DateTime :created_at
    Integer :updated_at
    String :summary, text: true
  end
end
