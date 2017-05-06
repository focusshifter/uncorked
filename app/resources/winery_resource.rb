class WineryResource < BaseResource
  def allowed_methods
    %w[GET HEAD]
  end

  def resource_exists?
    @winery = Winery.find(uuid: request.path_info[:id])
  end
end
