class SignupResource < BaseResource
  def allowed_methods
    %w[POST]
  end

  def resource_exists?
    true
  end

  def post_is_create?
    true
  end

  def create_path
    url_for(SignupResource)
  end

  def from_json
    @user = User.new(params)
    @user.uuid = next_id

    return json_validation_errors(@user) unless @user.valid?

    @user.save

    @token = generate_token(@user)

    response.headers['Content-Type'] = 'application/hal+json'
    response.body = render
  end

  def next_id
    @next_id ||= SecureRandom.uuid
  end
end
