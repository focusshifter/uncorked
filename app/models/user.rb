class User < Sequel::Model
  plugin :uuid, field: :uuid
  plugin :timestamps
  plugin :association_dependencies
  plugin :validation_helpers

  one_to_many :reviews

  add_association_dependencies reviews: :delete

  def validate
    super
    validates_presence [:email, :name]
    validates_unique [:email, :uuid]
  end
end
