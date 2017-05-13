require 'highline'
require 'hyper_resource'

CLI = HighLine.new
CLI.say 'Uncorked Client'

api_root_path = CLI.ask('API root path?') { |q| q.default = 'http://localhost:3000' }

require './actions/entrypoint_action'
require './actions/winery_action'
# require './actions/wine_action'
# require './actions/review_action'
require './actions/user_action'

class UncorkedClient
  def initialize(root_path)
    @root_path = root_path
    @headers = {
      'Accept' => 'application/hal+json',
      'Content-Type' => 'application/json'
    }
  end

  def query
    @api ||= hyperresource
  end

  def authorize(token)
    @token = token
    auth_header = { 'Authorization' => "Bearer #{@token}" }
    @headers.merge! auth_header

    renew_hyperresource
  end

  def authorized?
    !@token.nil?
  end

  private

  def hyperresource
    HyperResource.new(root: @root_path, headers: @headers)
  end

  def renew_hyperresource
    @api = hyperresource
  end
end

API = UncorkedClient.new(api_root_path)

EntrypointAction.root
