class User < Sequel::Model
  plugin :uuid, field: :uuid
  plugin :timestamps
  plugin :association_dependencies

  one_to_many :reviews

  add_association_dependencies reviews: :delete
end
