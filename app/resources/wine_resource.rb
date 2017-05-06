class WineResource < BaseResource
  def allowed_methods
    %w[GET HEAD]
  end

  def resource_exists?
    @wine = Wine.find(uuid: request.path_info[:id])
  end
end
