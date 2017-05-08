class Wine < Sequel::Model
  plugin :uuid, field: :uuid
  plugin :timestamps

  many_to_one :winery
  one_to_many :reviews
end
