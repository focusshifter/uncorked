require 'webmachine'
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
    add ['wineries', :winery_id, 'wines'], WinesResource

    add ['wines'], WinesResource
    add ['wines', :id], WineResource

    add ['wines', :id, 'reviews'], WineReviewsResource

    add ['user', :id, 'reviews'], UserReviewsResource

    add ['login'], LoginResource
    add ['signup'], SignupResource

    add [:*], EntrypointResource
  end

  app.configure do |config|
    config.ip = '0.0.0.0'
    config.port = 3000
    config.adapter = :WEBrick
  end

  app.inject_resource_url_provider
end

App.run
