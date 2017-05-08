class User < Sequel::Model
  plugin :uuid, field: :uuid
  plugin :timestamps

  one_to_many :reviews
end
