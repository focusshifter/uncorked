class Winery < Sequel::Model
  plugin :uuid, field: :uuid
  plugin :timestamps
end
