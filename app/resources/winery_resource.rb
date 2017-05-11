class WineryResource < BaseResource
  def allowed_methods
    %w[GET HEAD DELETE]
  end

  def resource_exists?
    winery
  end

  def protected_resource?
    true
  end

  def winery
    @winery ||= Winery.find(uuid: request.path_info[:id])
  end

  def delete_resource
    winery.destroy

    true
  end
end
