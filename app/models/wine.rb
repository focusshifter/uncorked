class Wine < Sequel::Model
  plugin :uuid, field: :uuid
  plugin :timestamps
  plugin :association_dependencies
  plugin :validation_helpers

  many_to_one :winery
  one_to_many :reviews

  add_association_dependencies reviews: :delete

  def validate
    super
    validates_presence [:title, :winery_id]
    validates_unique :uuid
  end
end
