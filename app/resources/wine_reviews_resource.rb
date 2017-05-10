class WineReviewsResource < BaseResource
  def allowed_methods
    %w[GET HEAD]
  end

  def resource_exists?
    wine
  end

  def wine
    @wine ||= Wine.find(uuid: request.path_info[:id])
  end

  def to_json
    @reviews ||= Review.where(wine_id: wine.id).all

    render
  end
end
