class LoginResource < BaseResource
  def allowed_methods
    %w[POST]
  end

  def resource_exists?
    true
  end
end
