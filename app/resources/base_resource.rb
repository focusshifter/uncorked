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

  def is_authorized?(authorization_header)
    return true unless protected_resource?

    return false unless authorization_header

    token = authorization_header.scan(/Bearer (.*)$/).flatten.last
    authorize(token)
  end

  def to_json
    prepare_data

    render
  end

  def prepare_data
  end

  def authorize(token)
    auth = JWT.decode(token, auth_secret, true, algorithm: 'HS256').first

    user = User.find(id: auth['user'])

    return false unless user

    @current_user = user
  end

  def logged_in?
    current_user
  end

  def protected_resource?
    false
  end
end
