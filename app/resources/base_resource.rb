class BaseResource < Webmachine::Resource
  include Webmachine::Linking::Urlify
  include Webmachine::JbuilderView

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

  def finish_request
    response.headers['Access-Control-Allow-Origin'] = '*'
    response.headers['Access-Control-Allow-Methods'] = 'GET, POST, PUT, DELETE'
  end
end
