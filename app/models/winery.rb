# = Winery
class Winery < Sequel::Model
  plugin :uuid, field: :uuid
  plugin :timestamps
  plugin :association_dependencies
  plugin :validation_helpers

  one_to_many :wines
  add_association_dependencies wines: :delete

  def validate
    super
    validates_presence :title
    validates_unique :uuid
  end
end
