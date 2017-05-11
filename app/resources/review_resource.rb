class ReviewResource < BaseResource
  def allowed_methods
    %w[GET HEAD DELETE]
  end

  def resource_exists?
    review
  end

  def protected_resource?
    true
  end

  def review
    path_info = request.path_info

    @wine ||= Wine.find(uuid: path_info[:wine_id])

    return false unless @wine

    @review ||= Review.find(uuid: path_info[:id], wine: @wine)
  end

  def delete_resource
    review.destroy

    true
  end
end
