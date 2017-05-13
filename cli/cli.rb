require 'highline'
require 'hal-client'

require './actions/entrypoint_action'
require './actions/winery_action'
require './actions/wine_action'
require './actions/review_action'
require './actions/user_action'

# = UncorkedClient
#
# Shared API (hal-client) interface
class UncorkedClient
  def initialize(root_path)
    @root_path = root_path
    @headers = {}
  end

  def root
    @api ||= client
  end

  def authorize(token)
    @token = token
    auth_header = { 'Authorization' => "Bearer #{@token}" }
    @headers.merge! auth_header

    renew_client
  end

  def authorized?
    !@token.nil?
  end

  private

  def client
    hal_client = HalClient.new(accept: 'application/hal+json',
                               content_type: 'application/json',
                               headers: @headers)
    hal_client.get(@root_path)
  end

  def renew_client
    @api = client
  end
end

CLI = HighLine.new
CLI.say 'Welcome to Uncorked Client'

api_root_path = CLI.ask('Set API root path (default will work in dev environment)') do |q|
  q.default = 'http://localhost:3000'
end

API = UncorkedClient.new(api_root_path)

EntrypointAction.root
