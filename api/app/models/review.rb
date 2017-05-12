# = Review
#
# Contains an User's review for the Wine
class Review < Sequel::Model
  plugin :uuid, field: :uuid
  plugin :timestamps
  plugin :validation_helpers

  many_to_one :wine
  many_to_one :user

  def validate
    super
    validates_presence %i[summary rating wine user]
    validates_unique :uuid
    validates_includes [1, 2, 3, 4, 5], :rating
  end
end
