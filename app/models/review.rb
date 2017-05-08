class Review < Sequel::Model
  plugin :uuid, field: :uuid
  plugin :timestamps

  many_to_one :user
  many_to_one :wine
end
