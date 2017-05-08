class WinesResource < BaseResource
  def allowed_methods
    %w[GET HEAD]
  end

  def resource_exists?
    winery
  end

  def winery
    @winery ||= Winery.find(uuid: request.path_info[:winery_id])
  end
end
