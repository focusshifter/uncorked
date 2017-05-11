require 'byebug'

class ReviewsResource < BaseResource
  def allowed_methods
    %w[GET HEAD POST]
  end

  def resource_exists?
    wine
  end

  def protected_resource?
    true
  end

  def post_is_create?
    true
  end

  def wine
    @wine ||= Wine.find(uuid: request.path_info[:wine_id])
  end

  def create_path
    url_for(ReviewResource, wine_id: wine.uuid, id: next_id)
  end

  def from_json
    @review = Review.new(params)

    @review.wine = wine
    @review.user = current_user

    @review.uuid = next_id

    return json_validation_errors(@review) unless @review.valid?

    @review.save

    response.body = render('review_resource')
  end

  def next_id
    @next_id ||= SecureRandom.uuid
  end

  def to_json
    @reviews ||= Review.where(wine_id: wine.id).all

    render
  end
end
