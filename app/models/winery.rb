class Winery < Sequel::Model
  plugin :uuid, field: :uuid
  plugin :timestamps
  plugin :association_dependencies

  one_to_many :wines
  add_association_dependencies wines: :delete
end
