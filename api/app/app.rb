require 'webmachine'
require 'webmachine/adapters/rack'
require 'webmachine-linking'

require 'sequel'
require 'jbuilder'

require './ext/webmachine/jbuilder_view'
require './ext/webmachine/linking/urlify'

require './db/config'

require './app/models/winery'
require './app/models/user'
require './app/models/wine'
require './app/models/review'

require './app/resources'

App = Webmachine::Application.new do |app|
  app.routes do
    add ['trace', :*], Webmachine::Trace::TraceResource

    add ['wineries'], WineriesResource
    add ['wineries', :id], WineryResource

    add ['wines'], WinesResource
    add ['wines', :id], WineResource

    add ['wines', :wine_id, 'reviews'], ReviewsResource
    add ['wines', :wine_id, 'reviews', :id], ReviewResource

    add ['login'], LoginResource
    add ['signup'], SignupResource

    add [:*], EntrypointResource
  end

  app.configure do |config|
    config.ip = '0.0.0.0'
    config.port = 3000
    config.adapter = :Rack
  end

  app.inject_resource_url_provider
end
