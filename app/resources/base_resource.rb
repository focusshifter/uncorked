require 'jwt'

class BaseResource < Webmachine::Resource
  include Webmachine::Linking::Urlify
  include Webmachine::JbuilderView

  attr_reader :current_user

  def trace?
    false
  end

  def content_types_accepted
    [['application/json', :from_json]]
  end

  def content_types_provided
    [['application/hal+json', :to_json]]
  end

  def to_json
    render
  end

  def params
    @params ||= JSON.parse(request.body.to_s)
  end

  def json_errors(errors)
    response.body = { errors: errors }.to_json
    400
  end

  def json_validation_errors(object)
    response.body = { errors: object.errors }.to_json
    400
  end

  def auth_secret
    ENV['AUTH_SECRET']
  end

  def is_authorized?(authorization_header)
    return true unless protected_resource?

    return false unless authorization_header

    token = authorization_header.scan(/Bearer (.*)$/).flatten.last

    authorize(token)

    logged_in?
  end

  def authorize(token)
    auth = JWT.decode(token, auth_secret, true, algorithm: 'HS256').first

    @current_user = User.find(auth['user_id'])
  end

  def generate_token(user)
    @token = JWT.encode({ user_id: user.id }, auth_secret, 'HS256')
  end

  def logged_in?
    !!current_user
  end

  def protected_resource?
    false
  end
end
