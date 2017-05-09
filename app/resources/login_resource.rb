class LoginResource < BaseResource
  def allowed_methods
    %w[POST]
  end

  def resource_exists?
    true
  end

  def forbidden?
    email = params['email']
    password = params['password']

    @user = User.find(email: email)

    !@user
  end

  def process_post
    payload = { user_id: @user.id }
    @token = JWT.encode(payload, auth_secret, 'HS256')

    response.headers['Content-Type'] = 'application/hal+json'
    response.body = render
    true
  end
end
