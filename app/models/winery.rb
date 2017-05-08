class Winery < Sequel::Model
  plugin :uuid, field: :uuid
  plugin :timestamps

  one_to_many :wines
end
