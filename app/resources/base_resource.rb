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

  def prepare_data
  end

  def params
    @params ||= JSON.parse(request.body.to_s)
  end

  def auth_secret
    "Sw\xAC\xCBGg\xD8q<I\x8Di#\f\xE7\xECd\v\xBE\xD6\xAA\xC0\xEE\xA1\xF5\xC4\x8D\xA0\xEB\xA5\xEC\xE9"
  end

  def is_authorized?(authorization_header)
    return true unless protected_resource?

    return false unless authorization_header

    token = authorization_header.scan(/Bearer (.*)$/).flatten.last

    authorize(token)
  end

  def authorize(token)
    auth = JWT.decode(token, auth_secret, true, algorithm: 'HS256').first

    @current_user = User.find(auth['user_id'])

    !!current_user
  end

  def logged_in?
    current_user
  end

  def protected_resource?
    false
  end
end
