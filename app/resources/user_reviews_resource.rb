class UserReviewsResource < BaseResource
  def allowed_methods
    %w[GET HEAD]
  end

  def resource_exists?
    user
  end

  def user
    @user ||= User.find(uuid: request.path_info[:id])
  end

  def prepare_data
    @reviews ||= Review.where(user_id: user.id).all
  end
end
