RESOURCES = %w[
  base

  wineries
  winery

  wines
  wine

  entrypoint
  signup
  login
].freeze

current_path = File.dirname(__FILE__)

RESOURCES.each do |resource|
  require File.join(current_path, 'resources', "#{resource}_resource")
end
