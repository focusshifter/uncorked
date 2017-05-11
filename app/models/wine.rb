class Wine < Sequel::Model
  plugin :uuid, field: :uuid
  plugin :timestamps
  plugin :association_dependencies

  many_to_one :winery
  one_to_many :reviews

  add_association_dependencies reviews: :delete
end
