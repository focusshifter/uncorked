class LoginResource < BaseResource
  def allowed_methods
    %w[POST]
  end

  def resource_exists?
    true
  end

  def forbidden?
    email = params['email']

    @user = User.find(email: email)

    !@user
  end

  def process_post
    @token = generate_token(@user)

    response.headers['Content-Type'] = 'application/hal+json'
    response.body = render
    true
  end
end
