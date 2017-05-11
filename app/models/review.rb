class Review < Sequel::Model
  plugin :uuid, field: :uuid
  plugin :timestamps
  plugin :validation_helpers

  many_to_one :user
  many_to_one :wine

  def validate
    super
    validates_presence [:title, :rating, :wine_id, :user_id]
    validates_unique :uuid
  end
end
